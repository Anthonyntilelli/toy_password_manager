# frozen_string_literal: true

# View helpers for entire application
module ApplicationHelper
  # Returns if T/F user logged in
  def logged_in?
    !!get_user
  end

  # Returns user by id or nil
  def get_user
    User.find_by(id: session[:user_id])
  end
end
