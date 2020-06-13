class KeychainController < ApplicationController
  before_action :login_required
  before_action :resolve_keychain, except: [:new] # keep second
  before_action :keychain_member_required, except: [:new] # keep Third
  # before_action :keychain_must_be_admin, only: [:create, :edit, :destory]

  def show; end

  def new; end

  # TODO: create update (must have admin) edit (must have admin) destroy (must have admin)

  private

  # Determines if user is an active member of that keychain and sets @membership
  def keychain_member_required
    @membership = @keychain.active_members.find { |mem| mem.user == @user }
    return if @membership

    flash[:alert] = ['Not an active member of that keychain']
    redirect_to login_path, status: :unauthorized
  end

  # Sets @keychain and checks for invalid id
  def resolve_keychain
    kc_id = params[:id].to_i
    @keychain = nil
    @keychain = Keychain.find_by(id: kc_id) if !kc_id.zero? && kc_id.positive?
    return unless @keychain.nil?

    flash[:alert] = ['Invalid Keychain requested']
    redirect_to login_path, status: :bad_request
  end

  def keychain_must_be_admin
    return if @membership.admin

    flash[:alert] = ['You must be an admin of the keychain to proceed.']
    redirect_to login_path, status: :unauthorized
  end
end
