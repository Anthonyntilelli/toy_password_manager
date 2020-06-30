# frozen_string_literal: true

# Manages and validates Keychain
class Keychain < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 200 }
  after_validation :normalize_name

  # invite multiple users, all with same admin_bool
  # Creator of keychain is auto accepted and always admin.
  def self.create_with_mass_invite(name, creator, other_users, admin_bool)
    raise 'Other_users much be an array' unless other_users.is_a?(Array)
    raise 'Creater is in other_users list' if other_users.any?(creator)

    new_keychain = Keychain.create!(name: name)
    new_keychain.invite(creator, true).accept
    # mass assign
    other_users.each { |user| new_keychain.invite(user, admin_bool) } unless other_users.empty?
    new_keychain
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

  def active_members
    memberships.active
  end

  def inactive_members
    memberships.inactive
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
