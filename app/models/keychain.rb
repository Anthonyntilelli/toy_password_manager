class Keychain < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 200 }
  validates :name, format: { without: /~/, message: '~ is reserved.' }, unless: -> { personal }
  validates :name, format: { with: /~\d+/, message: 'personal keychains are ~user_id' }, if: -> { personal }
  validates :personal, inclusion: { in: [true, false] } # Ensure boolean

  after_validation :normalize_name

  # Invite users to Keychain
  def invite(user, admin_bool, re_invite = false)
    raise 'Invalid user' unless user.is_a?(User) && user.valid?

    memberships.find_by(user_id: user.id).destroy if re_invite
    memberships.create!(user_id: user.id, admin: admin_bool, invite_status: 'pending')
    memberships.find_by(user_id: user.id) # return created membership
  end

  private

  def normalize_name
    self.name = name.downcase.titleize
  end
end
