class SessionController < ApplicationController
  before_action :redirect_already_logged_in, except: :destroy
  def new; end

  def create
    return redirect_to(controller: 'main', action: 'new') if params_check

    user = User.find_by(email: params[:auth][:email].capitalize)
    user = user&.authenticate(params[:auth][:password])

    return redirect_to(controller: 'main', action: 'new') unless user

    session[:user_id] = user.id
    redirect_to controller: 'main', action: 'frontpage'
  end

  def destroy
    session.delete :user_id
    redirect_to controller: 'main', action: 'frontpage'
  end

  private

  def params_check
    params[:auth][:email]&.empty? || params[:auth][:password]&.empty?
  end

  def redirect_already_logged_in
    redirect_to controller: 'main', action: 'frontpage' if session[:user_id]&.integer?
  end
end
