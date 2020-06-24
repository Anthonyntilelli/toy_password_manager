# frozen_string_literal: true

# Manage Membership for users (keychain controller handles its membership)
class MembershipsController < ApplicationController
  before_action :login_required
  before_action :user_sub_item, only: :update
  before_action :user_must_own_membership, only: :update

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
