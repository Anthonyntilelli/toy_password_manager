class SessionController < ApplicationController
  before_action :redirect_already_logged_in, except: :destroy
  def new; end

  def create
    if params_check
      flash[:alert] = ['Missing email or password']
      return redirect_to login_path
    end

    user = User.find_by(email: params[:auth][:email].capitalize)
    user = user&.authenticate(params[:auth][:password])

    unless user
      flash[:alert] = ['Incorrect email or password']
      return redirect_to login_path
    end

    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  private

  def params_check
    params[:auth][:email]&.empty? || params[:auth][:password]&.empty?
  end
end
