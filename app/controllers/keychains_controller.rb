# frozen_string_literal: true

# Manage Keychain actions
class KeychainsController < BaseKeychainsContoller
  # login_required via BaseKeychainsContoller
  before_action :keychain_membership_required, except: %i[new create] # keep second
  before_action :user_must_be_admin_of_keychain, only: %i[edit destroy update inactive_members active_members]

  def show; end

  def new; end

  def inactive_members
    @user_type = 'inactive'
    @keychain_users = @keychain.inactive_members
    render 'activity_members'
  end

  def active_members
    @user_type = 'active'
    @keychain_users = @keychain.active_members
    render 'activity_members'
  end

  def create
    parsed = create_params_normalized
    pending_admins = create_emails_to_user(parsed[:emails])

    @keychain = Keychain.create_with_mass_invite(parsed[:name], @user, pending_admins, true)
    notice_and_redirect('Keychain Completed', keychain_path(@keychain))
  rescue ActiveRecord::RecordInvalid, RuntimeError => e
    alert_and_redirect(e.message, new_keychain_path, :bad_request)
  end

  def edit; end

  def update
    case params[:keychain][:update_action]
    when 'name'
      update_name(update_name_params)
    when 'admins'
      update_admins(update_admin_params_to_hash)
    else
      alert_and_redirect('Unknown update action', edit_keychain_path(@keychain))
    end
  end

  def destroy
    @keychain.destroy
    notice_and_redirect("#{@keychain.name} successfully deleted", user_path(@user))
  end

  private

  # Converts params to hash and normalize email
  def create_params_normalized
    pending = params.require(:keychain).permit(:name, :email_1, :email_2, :email_3, :email_4)
    {
      name: pending[:name],
      emails: [
        email_normalize(pending[:email_1]),
        email_normalize(pending[:email_2]),
        email_normalize(pending[:email_3]),
        email_normalize(pending[:email_4])
      ]
    }
  end

  def create_emails_to_user(email_array)
    email_error = []
    users = email_array.collect do |email|
      next if email.empty?

      user = User.find_by(email: email)
      email_error << "Email #{email} is not a valid user" unless user
      email_error << 'You must not be listed in optional admins, you are already an Admin' if user == @user
      user
    end
    return users.compact if email_error.empty?

    raise email_error.join(', ')
  end

  def update_admin_params_to_hash
    # Only membership ids
    ids = @keychain.active_members.collect { |mem| mem.id.to_s }
    params.require(:keychain).permit(ids).to_h
  end

  def update_name_params
    params.require(:keychain).permit(:name)
  end

  def update_admins(parsed_hsh)
    # check if change would remove all admins
    unless parsed_hsh.any? { |_k, v| v == '1' }
      return alert_and_redirect('There must be at least one admin', edit_keychain_path(@keychain), :bad_request)
    end

    @keychain.active_members.each do |mem|
      mem.admin = parsed_hsh[mem.id.to_s] == '1'
      mem.save!
    end
    notice_and_redirect('Updated Admins', keychain_path(@keychain))
  end

  def update_name(parsed_params)
    return notice_and_redirect('Updated Name', keychain_path(@keychain)) if @keychain.update(name: parsed_params[:name])

    multi_alerts_and_redirect(@keychain.errors.full_messages, edit_keychain_path(@keychain), :bad_request)
  end
end
