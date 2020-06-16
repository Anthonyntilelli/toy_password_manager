# frozen_string_literal: true

# Manage Membership for users (keychain controller handles its membership)
class MembershipController < ApplicationController
  before_action :login_required
  # to do limit to user_id of membership

  def update
    byebug
  end
end
