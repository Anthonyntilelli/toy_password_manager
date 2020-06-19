# frozen_string_literal: true

# Manage Membership for keychains
class Keychain::SubController < ApplicationController
  before_action :login_required
  before_action :resolve_keychain

  private

  def resolve_keychain
    @keychain = if request.method == 'POST'
                  Keychain.find_by(id: params[controller_name.to_sym][:kc])
                elsif request.method == 'GET'
                  Keychain.find_by(id: params[:kc])
                end
    return if @keychain.is_a?(Keychain)

    flash[:alert] = ['Unsupported Method']
    redirect_to user_path(@user), status: :forbidden
  end
end
