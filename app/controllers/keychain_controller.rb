class KeychainController < ApplicationController
  before_action :login_required
  before_action :resolve_keychain, except: [:new, :create] # keep second
  before_action :keychain_member_required, except: [:new, :create] # keep Third
  # before_action :keychain_must_be_admin, only: [:update, :edit, :destory]
  before_action :check_admin_create, only: :create

  def show; end

  def new; end

  def create
    # Relives on `check_admin_create`
    raise 'Must run `check_admin_create` method first' if @pending_admins.nil?

    @keychain = Keychain.new(params.require(:keychain).permit(:name))
    if @keychain.save
      admin_users = [@user]
      @pending_admins.each { |aae| admin_users << User.find_by(email: aae) }
      admin_users.compact!
      admin_users.each do |person|
        mem = @keychain.invite(person, true, false)
        mem.accept if @user == person # creator of keychain is auto accepted
      end
      flash[:notice] = ['Keychain Completed']
      return redirect_to keychain_path(@keychain)
    end
    flash[:alert] = @keychain.errors.full_messages
    redirect_to new_keychain_path, status: :bad_request
  end

  # TODO: update (must have admin) edit (must have admin) destroy (must have admin)

  private

  # Determines if user is an active member of that keychain and sets @membership
  def keychain_member_required
    @membership = @keychain&.active_members&.find { |mem| mem.user == @user }
    return if @membership

    flash[:alert] = ['Not an active member of that keychain']
    redirect_to login_path, status: :unauthorized
  end

  # Sets @keychain and checks for invalid id
  def resolve_keychain
    kc_id = params[:id].to_i
    @keychain = nil
    @keychain = Keychain.find_by(id: kc_id) if !kc_id.zero? && kc_id.positive?
    return unless @keychain.nil?

    flash[:alert] = ['Invalid Keychain requested']
    redirect_to login_path, status: :bad_request
  end

  def keychain_must_be_admin
    return if @membership.admin

    flash[:alert] = ['You must be an admin of the keychain to proceed.']
    redirect_to login_path, status: :unauthorized
  end

  def check_admin_create
    list = params.require(:keychain).permit(:name, :email_1, :email_2, :email_3, :email_4)
    email = []
    @pending_admins = [
      email_normalize(list[:email_1]),
      email_normalize(list[:email_2]),
      email_normalize(list[:email_3]),
      email_normalize(list[:email_4])
    ]

    @pending_admins.each_with_index do |pa,index|
      if pa != ''
        email << "Email #{index + 1} is not a valid user" unless User.exists?(email: pa)
        email << "Email #{index + 1} must not be you, you are already an Admin" if pa == @user.email
      end
    end
    return if email.empty?

    flash[:alert] = email
    redirect_to new_keychain_path, status: :bad_request
  end
end
