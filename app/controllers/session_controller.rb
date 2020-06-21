# frozen_string_literal: true

# Manage login and logout
class SessionController < ApplicationController
  before_action :redirect_already_logged_in, except: %i[destroy create_omniauth]
  def new; end

  def create
    if params_check
      flash[:alert] = ['Missing email or password']
      return redirect_to login_path
    end

    user = User.find_by(email: email_normalize(params[:auth][:email]))
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

  def create_omniauth
    email = email_normalize(auth_hash[:info][:email])
    if email.nil?
      flash[alert] = ['Email is set to private in Github' ]
      redirect_to '/', status: :bad_request
    end

    user = User.find_by(email: email)
    unless user # Create user
      name = auth_hash[:info][:name]
      user = User.create_oauth(name, email)
    end

    if user.valid? && user.persisted?
      session[:user_id] = user.id
      return redirect_to user_path(user)
    end

    flash[:alert] = user.errors.full_messages
    redirect_to '/', status: :bad_request
  end

  private

  def params_check
    params[:auth][:email]&.empty? || params[:auth][:password]&.empty?
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
