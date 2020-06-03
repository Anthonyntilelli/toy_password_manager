class ApplicationController < ActionController::Base
  private

  # Check for logged in user and set @user
  def login_required
    @user = User.find_by(id: session[:user_id])
    return if @user # clear potentually bad session and flash info

    session[:user_id] = nil
    flash[:notice] = ['You must login first.']
    redirect_to(controller: 'session', action: 'new')
  end

  def redirect_already_logged_in
    redirect_to controller: 'main', action: 'frontpage' if session[:user_id]&.integer?
  end
end
