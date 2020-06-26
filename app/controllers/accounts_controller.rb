# frozen_string_literal: true

# Manage Membership for keychains
class AccountsController < BaseKeychainsContoller
  # login_required via BaseKeychainsContoller
  before_action :keychain_membership_required
  before_action :resolve_account, except: %i[new create]

  def show; end

  def new; end

  def edit; end

  def create
    @keychain.add_account(create_params.to_h)
    notice_and_redirect('Account created', keychain_path(@keychain))
  rescue ActiveRecord::RecordInvalid, RuntimeError => e
    alert_and_redirect(e.message, keychain_path(@keychain), :bad_request)
  end

  def update
    if @account.update(update_params)
      notice_and_redirect('Account update completed', keychain_account_path(@keychain, @account))
    else
      multi_alerts_and_redirect(@account.errors.full_messages, keychain_account_path(@keychain, @account), :bad_request)
    end
  end

  def destroy
    @account.destroy
    notice_and_redirect('Account Deleted', keychain_path(@keychain))
  end

  private

  def update_params
    params.require(:account).permit(:name, :url, :username, :password)
  end

  def create_params
    params.require(:account).permit(:name, :url, :username, :password)
  end

  def resolve_account
    @account = @keychain.accounts.find_by(id: params[:id])
    return if @account.is_a?(Account)

    alert_and_redirect('Invalid account or not part of this keychain', login_path, :unauthorized)
  end
end
