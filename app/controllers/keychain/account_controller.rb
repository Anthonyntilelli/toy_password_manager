# new_keychain_account   GET    /keychain/account/new(.:format)                                                          keychain/account#new
# keychain_account_index POST   /keychain/account(.:format)                                                               keychain/account#create
# edit_keychain_account  GET    /keychain/account/:id/edit(.:format)                                                      keychain/account#edit
#      keychain_account  GET    /keychain/account/:id(.:format)                                                           keychain/account#show
#                        PATCH  /keychain/account/:id(.:format)                                                           keychain/account#update
#                        PUT    /keychain/account/:id(.:format)                                                           keychain/account#update
#                        DELETE /keychain/account/:id(.:format)                                                           keychain/account#destroy

# frozen_string_literal: true

# Manage Membership for keychains
class Keychain::AccountController < Keychain::SubController

  def create
    begin
      @keychain.add_account(params.require(:account).permit(:name, :url, :username, :password).to_h)
      flash[:notice] = ['Account created']
      return redirect_to keychain_path(@keychain)
    rescue ActiveRecord::RecordInvalid, RuntimeError => e
      flash[:alert] = [e.message]
    end
    redirect_to keychain_path(@keychain), status: :bad_request
  end


  def edit; end

  def show; end

  def update; end

  def destory; end
end
