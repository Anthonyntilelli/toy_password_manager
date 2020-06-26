# frozen_string_literal: true

# Manage Users Interactions
class UsersController < ApplicationController
  before_action :login_required, except: %i[new create]
  before_action :redirect_already_logged_in, only: %i[new create]
  before_action :user_id_match, except: %i[new create]
  before_action :require_current_password, only: %i[update destroy]

  def new; end

  def create
    user = User.new(params.require(:user).permit(:name, :email, :email_confirmation, :password, :password_confirmation))
    if user.save # User created
      session[:user_id] = user.id
      return redirect_to user_path(user)
    end
    multi_alerts_and_redirect(user.errors.full_messages, signup_path, :bad_request)
  end

  def show; end

  def edit; end

  def update
    if @user.update(params_strong)
      notice_and_redirect('Update Successfull', edit_user_path(@user))
    else
      multi_alerts_and_redirect(@user.errors.full_messages, edit_user_path(@user), :bad_request)
    end
  end

  def destroy
    @user.last_member.each(&:destroy)
    @user.destroy
    session.delete :user_id
    notice_and_redirect('User destroyed', root_url)
  end

  private

  def params_strong
    params.require(:user).permit(:password, :password_confirmation, :name)
  end

  # params id must match @user.id
  def user_id_match
    return if @user.id == params[:id].to_i

    alert_and_redirect('Not your user', user_path(@user), :forbidden)
  end

  def require_current_password
    # Skip Current Password Check
    return if @user.dummy_password
    return if action_name == 'update' && params_strong[:password].nil?
    # Valid current password
    return if @user.authenticate(params[:user][:current_password])

    alert_and_redirect('Current password incorrect', edit_user_path(@user), :forbidden)
  end
end
