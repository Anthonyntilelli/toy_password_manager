# frozen_string_literal: true

# Manage Membership for keychains
class Keychain::MembershipController < ApplicationController
  before_action :login_required
  before_action :resolve_keychain
  before_action :must_be_admin_of_keychain

  def new; end

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

  def resolve_keychain
    @keychain = if request.method == 'POST'
                  Keychain.find_by(id: params[:membership][:kc])
                elsif request.method == 'GET'
                  Keychain.find_by(id: params[:kc])
                end
    return if @keychain.is_a?(Keychain)

    flash[:alert] = ['Unsupported Method']
    redirect_to user_path(@user), status: :forbidden
  end

  # determines if you are an admin
  def must_be_admin_of_keychain
    return if @keychain&.admin?(@user)

    flash[:alert] = ['Invalid keychain or User is not an Admin'] if flash[:alert].nil?
    redirect_to user_path(@user), status: :forbidden
  end
end
