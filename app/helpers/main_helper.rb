# frozen_string_literal: true

# View helper for FrontPage
module MainHelper
  # Returns if T/F user logged in
  def logged_in?
    !!active_user
  end

  # Returns user by id or nil
  def active_user
    User.find_by(id: session[:user_id])
  end
end
