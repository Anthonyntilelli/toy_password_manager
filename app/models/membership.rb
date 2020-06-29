# frozen_string_literal: true

# Manages and validates memberships
class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :keychain

  validates :keychain, presence: true
  validates :user, presence: true, uniqueness: {
    scope: :keychain, message: 'is already a member or declined membership.'
  }
  validates :invite_status, inclusion: {
    in: %w[pending accepted declined left],
    message: 'Valid status are only pending, accepted, declined, left'
  }
  validates :admin, inclusion: { in: [true, false] } # boolean validation

  scope :active, -> { where(invite_status: 'accepted') }
  scope :inactive, -> { where.not(invite_status: 'accepted') }
  scope :active_admin, -> { where(admin: true, invite_status: 'accepted') }

  def decline
    pending?
    # Remove admin also on decline
    update(invite_status: 'declined', admin: false)
    save!
  end

  def accept
    pending?
    update(invite_status: 'accepted')
    save!
  end

  def leave
    # Remove admin also on leave
    raise 'membership must be accepted to leave.' unless invite_status == 'accepted'

    update(invite_status: 'left', admin: false)
    save!
  end

  private

  def pending?
    raise 'membership must be pending.' unless invite_status == 'pending'
  end
end
