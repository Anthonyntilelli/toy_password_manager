# frozen_string_literal: true

# Manages and validates Keychain
class Keychain < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 200 }
  after_validation :normalize_name

  # invite multiple users, all with same admin_bool
  def mass_invite(users, admin_bool)
    raise 'users much be an array' unless users.is_a?(Array)

    # return created memberships
    users.collect { |user| invite(user, admin_bool) }
  end

  # Invite users to Keychain
  def invite(user, admin_bool)
    raise 'User not found' unless user.is_a?(User) && user.valid?

    memberships.create!(user_id: user.id, admin: admin_bool, invite_status: 'pending')
    memberships.find_by(user_id: user.id) # return created membership
  end

  def add_account(account_hash)
    raise 'Must be a hash' unless account_hash.is_a?(Hash)

    accounts.create!(account_hash)
  end

  # returns list of all active memberships
  def active_members
    memberships.select { |mem| mem.invite_status == 'accepted' }
  end

  def admin?(user)
    raise 'Must be a user.' unless user.is_a?(User)
    return true if memberships.find_by(user_id: user.id).admin

    false
  end

  private

  def normalize_name
    self.name = name.downcase.titleize
  end
end
