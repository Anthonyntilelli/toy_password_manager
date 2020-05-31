class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :keychain

  validates :keychain, presence: true
  validates :user, presence: true, uniqueness: { scope: :keychain, message: 'is already a member or declined membership.' }
  validates :invite_status, inclusion: { in: %w[pending accepted declined], message: '%{value} is not a valid status' }
  validates :admin, inclusion: { in: [true, false] } # boolean validation
end
