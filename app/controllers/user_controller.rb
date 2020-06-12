class UserController < ApplicationController
  before_action :login_required, except: %i[new create]
  before_action :redirect_already_logged_in, only: %i[new create]
  before_action :id_match, except: %i[new create]

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
    parsed_params = params_strong
    # Ask for password change and invalid current password
    if parsed_params[:password] && !@user.authenticate(params[:user][:current_password])
      flash[:alert] = ['Current password incorrect']
      return redirect_to edit_user_path(@user)
    end

    if @user.update(parsed_params)
      flash[:notice] = ['Update Successfull']
    else
      flash[:alert] = @user.errors.full_messages
    end
    redirect_to edit_user_path(@user)
  end

  def destroy
    parsed_params = params.require(:user).permit(:current_password)
    if @user.authenticate(parsed_params[:current_password])
      @user.last_member.each(&:destroy)
      @user.destroy
      session.delete :user_id
      flash[:notice] = ['User destroyed']
      return redirect_to '/'
    end
    flash[:alert] ||= ['Current password incorrect']
    redirect_to edit_user_path(@user)
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
end
