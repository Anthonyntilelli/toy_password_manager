# frozen_string_literal: true

# Manage Membership for keychains
class AccountsController < BaseKeychainsContoller
  # login_required via BaseKeychainsContoller
  before_action :resolve_keychain, only: %i[new create]
  before_action :resolve_keychain_and_account, except: %i[new create]
  before_action :keychain_members_only

  def new; end

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

  def show; end

  def edit; end

  def update
    if @account.update(strong_params)
      flash[:notice] = ['Account update completed']
      redirect_to keychain_account_path(@account)
    else
      flash[:alert] = @account.errors.full_messages
      redirect_to keychain_account_path(@account), status: :bad_request
    end
  end

  def destroy
    @account.destroy
    flash[:notice] = ['Account Deleted']

    redirect_to keychain_path(@keychain)
  end

  private

  def strong_params
    params.require(:account).permit(:keychain_id, :name, :url, :username, :password)
  end

  def resolve_keychain_and_account
    @account = Account.find_by(id: params[:id])
    @keychain = @account&.keychain
    return if @account.is_a?(Account)

    flash[:alert] = ['invalid Account']
    redirect_to login_path, status: :unauthorized
  end

  # Determines if user is an active member of that keychain
  def keychain_members_only
    return if @keychain&.active_members&.find { |mem| mem.user == @user }

    flash[:alert] = ['Not an active member of that keychain']
    redirect_to login_path, status: :unauthorized
  end
end
