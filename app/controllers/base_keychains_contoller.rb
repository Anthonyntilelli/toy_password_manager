# frozen_string_literal: true

# Base for Keychain  and subsets
class BaseKeychainsContoller < ApplicationController
  before_action :login_required

  private

  def user_must_be_admin_of_keychain
    return if @user_membership.admin

    flash[:alert] = ['You must be an admin of the keychain to proceed.']
    redirect_to login_path, status: :unauthorized
  end

  # Sets @keychains and @user_membership
  # Redirects if user if not an active member.
  def keychain_membership_required
    @keychain = @user.keychains.find_by(id: params[:id]&.to_i) || @user.keychains.find_by(id: params[:keychain_id]&.to_i)
    @user_membership = @keychain&.active_members&.find { |mem| mem.user == @user } if @keychain
    return if @user_membership

    alert_and_redirect('Invalid Keychain or you are not an active member', user_path(@user), :bad_request)
  end
end
