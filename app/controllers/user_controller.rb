# frozen_string_literal: true

# Manage User Interactions
class UserController < ApplicationController
  before_action :login_required, except: %i[new create]
  before_action :redirect_already_logged_in, only: %i[new create]
  before_action :id_match, except: %i[new create]
  before_action :require_current_password, only: %i[update destroy]

  def new; end

  def create
    user = User.new(params.require(:user).permit(:name, :email, :email_confirmation, :password, :password_confirmation))
    if user.save # User created
      session[:user_id] = user.id
      return redirect_to user_path(user)
    end
    flash[:alert] = user.errors.full_messages
    redirect_to signup_path
  end

  def show; end

  def edit; end

  def update
    if @user.update(params_strong)
      flash[:notice] = ['Update Successfull']
    else
      flash[:alert] = @user.errors.full_messages
    end
    redirect_to edit_user_path(@user)
  end

  def destroy
    @user.last_member.each(&:destroy)
    @user.destroy
    session.delete :user_id
    flash[:notice] = ['User destroyed']
    redirect_to '/'
  end

  private

  def params_strong
    params.require(:user).permit(:password, :password_confirmation, :name)
  end

  # Url id must match <model>.id
  def id_match
    return if @user.id == params[:id].to_i

    # clear potentially bad session and flash info
    flash[:alert] = ['You are not permitted to selected id.']
    redirect_to login_path, status: :forbidden
  end

  def require_current_password
    # Skip Current Password Check
    return if @user.dummy_password
    return if action_name == 'update' && params_strong[:password].nil?
    # Valid current password
    return if @user.authenticate(params[:user][:current_password])

    flash[:alert] = ['Current password incorrect']
    redirect_to edit_user_path(@user)
  end
end
