class UserController < ApplicationController
  before_action :login_required, except: [ :new, :create ]
  before_action :redirect_already_logged_in, only: [ :new, :create ]

  def new; end

  def create
    user = User.new(params.require(:user).permit(:name, :email, :email_confirmation, :password, :password_confirmation))
    if user.save
      session[:user_id] = user.id
      return redirect_to controller: 'session', action: 'show'
    end
    flash[:alert] = user.errors.full_messages
    redirect_to controller: 'user', action: 'new'
  end

  def show; end

  def edit; end

  def update
    parsed_params = params.require(:user).permit(:current_password, :password, :password_confirmation)
    if @user.authenticate(parsed_params[:current_password])
      @user.password = parsed_params[:password]
      @user.password_confirmation = parsed_params[:password_confirmation]
      flash[:notice] = ['Password Change completed!'] if @user.save
      flash[:alert] ||= @user.errors.full_message
    end

    flash[:alert] ||= ['Current password incorrect']
    redirect_to controller: 'user', action: 'show'
  end

  def destroy
  end
end
