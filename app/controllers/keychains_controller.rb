# frozen_string_literal: true

# Manage Keychain actions
class KeychainsController < BaseKeychainsContoller
  # login_required via BaseKeychainsContoller
  before_action :keychain_membership_required, except: %i[new create] # keep second
  before_action :user_must_be_admin_of_keychain, only: %i[edit destroy update]
  before_action :check_additional_admins_on_create, only: :create

  def show; end

  def new; end

  def create
    @keychain = Keychain.new(params.require(:keychain).permit(:name))
    if @keychain.save
      @keychain.invite(@user, true).accept # creator of keychain is auto accepted
      @keychain.mass_invite(@pending_admins, true)
      notice_and_redirect('Keychain Completed', keychain_path(@keychain))
    else
      multi_alerts_and_redirect(@keychain.errors.full_messages, new_keychain_path, :bad_request)
    end
  end

  def edit; end

  def update
    parsed_params = params.require(:keychain).permit!
    case params[:keychain][:update_action]
    when 'name'
      update_name(parsed_params)
    when 'admins'
      update_admins(parsed_params.to_h)
    else
      alert_and_redirect('UNKNOWN Update', edit_keychain_path(@keychain))
    end
  end

  def destroy
    @keychain.destroy
    notice_and_redirect("#{@keychain.name} successfully deleted", user_path(@user))
  end

  private

  def check_additional_admins_on_create
    list = params.require(:keychain).permit(:name, :email_1, :email_2, :email_3, :email_4)
    pending_emails = [
      email_normalize(list[:email_1]),
      email_normalize(list[:email_2]),
      email_normalize(list[:email_3]),
      email_normalize(list[:email_4])
    ]
    populate_pending_admins(pending_emails)
  end

  def populate_pending_admins(emails)
    email_error = []
    @pending_admins = []
    emails.each_with_index do |pa, index|
      next if pa.empty?

      user = User.find_by(email: pa)
      email_error << "Email #{index + 1} is not a valid user" unless user
      email_error << "Email #{index + 1} must not be you, you are already an Admin" if user == @user
      @pending_admins << user
    end
    return if email_error.empty?

    multi_alerts_and_redirect(email_error, new_keychain_path, :bad_request)
  end

  def update_admins(parsed_hsh)
    # Removes non-id (:update_action)
    changes = parsed_hsh.reject { |k, _v| k.to_i.zero? }
    # Change would remove all admins
    unless changes.any? { |_k, v| v == '1' }
      return alert_and_redirect('There must be at least one admin', edit_keychain_path(@keychain), :bad_request)
    end

    @keychain.active_members.each do |mem|
      mem.admin = changes[mem.id.to_s] == '1'
      mem.save!
    end
    notice_and_redirect('Updated Admins', edit_keychain_path(@keychain))
  end

  def update_name(parsed_params)
    if @keychain.update(name: parsed_params[:name])
      return notice_and_redirect('Updated Name', edit_keychain_path(@keychain))
    end

    multi_alerts_and_redirect(@keychain.errors.full_messages, edit_keychain_path(@keychain), :bad_request)
  end
end
