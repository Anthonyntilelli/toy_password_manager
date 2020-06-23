# frozen_string_literal: true

# Manage login and logout
class SessionsController < ApplicationController
  before_action :redirect_already_logged_in, except: %i[destroy create_omniauth]

  def new; end

  def create
    email = email_normalize(params[:auth][:email])
    password = params[:auth][:password]
    @user = User.find_by(email: email)&.authenticate(password)
    return alert_and_redirect('Incorrect email or password', login_path, :unauthorized) unless @user

    session_and_show_user
  end

  def destroy
    session.delete :user_id
    notice_and_redirect('Logged out', root_url)
  end

  def create_omniauth
    oauth_email_and_name
    return alert_and_redirect('Email not provided', root_url, :bad_request) if @email.nil?

    # Find or create
    @user = User.find_by(email: @email) || User.create_oauth(@name, @email)

    return session_and_show_user if @user.valid? && @user.persisted?

    flash[:alert] = @user.errors.full_messages
    redirect_to root_url, status: :bad_request
  end

  private

  # OmniAuth, sets @email and @name
  def oauth_email_and_name
    auth_hash = request.env['omniauth.auth']
    @email = email_normalize(auth_hash[:info][:email])
    @name = auth_hash[:info][:name]
  end

  # Set session and redirects to users#show
  def session_and_show_user
    session[:user_id] = @user.id
    notice_and_redirect('Logged In', user_path(@user))
  end
end
