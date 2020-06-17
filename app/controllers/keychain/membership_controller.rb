# frozen_string_literal: true

# Manage Membership for keychains
class Keychain::MembershipController < ApplicationController
  before_action :login_required
  before_action :must_be_admin_of_keychain

  def new; end

  def create; end

  private

  # Sets keychain and determines if you are a  admin
  def must_be_admin_of_keychain
    @keychain = Keychain.find_by(id: params[:kc])
    return if @keychain&.admin?(@user)

    flash[:alert] = ["Invalid keychain or User is not an Admin"]
    redirect_to user_path(@user), status: :forbidden
  end
end
