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

  # redirect and provide ONE MESSAGE on Error
  def alert_and_redirect(string_message, url, status)
    flash[:alert] = [string_message]
    redirect_to url, status: status
  end

  def multi_alerts_and_redirect(alerts, url, status)
    flash[:alert] = alerts
    redirect_to url, status: status
  end

  # redirect and provide ONE MESSAGE on Success
  def notice_and_redirect(string_message, url)
    flash[:notice] = [string_message]
    redirect_to url
  end
end
