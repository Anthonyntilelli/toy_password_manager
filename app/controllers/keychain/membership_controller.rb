# frozen_string_literal: true

# Manage Membership for keychains
class Keychain::MembershipController < Keychain::SubController
  before_action :must_be_admin_of_keychain

  def create
    begin
      @keychain.invite(
        User.find_by(email: email_normalize(params[:membership][:user_email])),
        params[:membership][:invite_as_admin] == '1',
        false
      )
      flash[:notice] = ['Invite sent']
      return redirect_to user_path(@user)
    rescue ActiveRecord::RecordInvalid, RuntimeError => e
      flash[:alert] = [e.message]
    end

    redirect_to keychain_path(@keychain), status: :bad_request
  end

  private

  # determines if you are an admin
  def must_be_admin_of_keychain
    return if @keychain&.admin?(@user)

    flash[:alert] = ['Invalid keychain or User is not an Admin'] if flash[:alert].nil?
    redirect_to user_path(@user), status: :forbidden
  end
end
