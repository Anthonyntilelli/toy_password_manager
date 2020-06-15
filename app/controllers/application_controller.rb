# frozen_string_literal: true

# Central application
class ApplicationController < ActionController::Base
  private

  # Check for logged in user and set @user
  def login_required
    @user = User.find_by(id: session[:user_id])
    return if @user

    # clear potentially bad session and flash info
    session[:user_id] = nil
    flash[:alert] = nil
    flash[:notice] = ['You must login first.']
    redirect_to login_path, status: :unauthorized
  end

  def redirect_already_logged_in
    redirect_to '/' if session[:user_id]&.integer?
  end

  def email_normalize(email)
    email&.strip&.capitalize
  end
end
