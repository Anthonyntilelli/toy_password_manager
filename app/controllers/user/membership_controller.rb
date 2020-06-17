# frozen_string_literal: true

# Manage Membership for users (keychain controller handles its membership)
class User::MembershipController < ApplicationController
  before_action :login_required
  before_action :resolve_membership
  # to do limit to user_id of membership

  def update
    case params[:invite_action]
    when 'leave'
      @membership.leave
      flash[:notice] = ['Left keychain successfully.']
    when 'accept'
      @membership.accept
      flash[:notice] = ['Accepted invite successfully']
    when 'decline'
      @membership.decline
      flash[:notice] = ['Declined invite successfully']
    end
    redirect_to user_path(@user)
  end

  private

  def resolve_membership
    @membership = @user.memberships.find_by(id: params[:id])
    return if @membership

    flash[:alert] = ['Invalid membership or not one of yours.']
    redirect_to login_path, status: :bad_request
  end
end
