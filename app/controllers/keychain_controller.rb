class KeychainController < ApplicationController
  before_action :login_required
  before_action :resolve_keychain # keep second
  before_action :keychain_member_required

  def show; end

  # TODO: update (must have admin)

  private

  # Determines if user is an actice member of that keychain
  def keychain_member_required
    return if @keychain.active_members.any? { |mem| mem.user == @user }

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
end
