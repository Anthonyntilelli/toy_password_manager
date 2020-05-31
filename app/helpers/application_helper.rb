module ApplicationHelper
  # Returns if T/F user logged in
  def logged_in?
    !!current_user
  end

  # Returns user by id or nil
  def current_user
    User.find_by(id: session[:user_id])
  end
end
