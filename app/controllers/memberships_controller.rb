# frozen_string_literal: true

# Manage Membership for users (keychain controller handles its membership)
class MembershipsController < BaseKeychainsContoller
  # Login Required via BaseKeychainsContoller
  before_action :user_sub_item, only: :update
  before_action :user_must_own_membership, only: :update
  before_action :keychain_membership_required, only: %i[new create]
  before_action :user_must_be_admin_of_keychain, only: %i[new create]

  # User modification
  def update
    case params[:invite_action]
    when 'leave'
      user_leave
      redirect_to user_path(@user)
    when 'accept'
      @membership.accept
      notice_and_redirect('Accepted invite successfully', user_path(@user))
    when 'decline'
      @membership.decline
      notice_and_redirect('Declined invite successfully', user_path(@user))
    end
  end

  # Keychain modification
  def new; end

  def create
    @keychain.invite(
      User.find_by(email: email_normalize(params[:membership][:user_email])),
      params[:membership][:invite_as_admin] == '1'
    )
    notice_and_redirect('Invite sent', user_path(@user))
  rescue ActiveRecord::RecordInvalid, RuntimeError => e
    alert_and_redirect(e.message, keychain_path(@keychain), :bad_request)
  end

  private

  # Set membership and check if user owns that membership
  def user_must_own_membership
    # User ID match
    @membership = @user.memberships.find_by(id: params[:id])
    return if @membership && @membership.invite_status != 'left'

    alert_and_redirect('Invalid membership or user has left.', login_path, :bad_request)
  end

  def user_sub_item
    return if params[:user_id] && params[:user_id].to_i == @user.id

    alert_and_redirect('Not your user', user_path(@user), :forbidden)
  end

  def user_leave
    @membership.leave
    flash[:notice] = ['Left keychain successfully.']
    kc = @membership.keychain
    return unless kc.active_members.count.zero? # No active members left

    kc.destroy
    flash[:notice] << 'Deleted keychain because all members have left.'
  end
end
