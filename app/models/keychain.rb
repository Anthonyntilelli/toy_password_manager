# frozen_string_literal: true

# Manages and validates Keychains
class Keychain < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 200 }
  after_validation :normalize_name

  # Invite users to Keychain
  def invite(user, admin_bool, re_invite = false)
    raise 'User not found' unless user.is_a?(User) && user.valid?

    memberships.find_by(user_id: user.id).destroy if re_invite
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
