class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :keychain

  validates :keychain, presence: true
  validates :user, presence: true, uniqueness: { scope: :keychain, message: 'is already a member or declined membership.' }
  validates :invite_status, inclusion: { in: %w[pending accepted declined left], message: '%{value} is not a valid status' }
  validates :admin, inclusion: { in: [true, false] } # boolean validation

  def decline
    pending?
    # Remove admin also on decline
    self.update(invite_status: 'declined', admin: false)
    self.save!
  end

  def accept
    pending?
    self.update(invite_status: 'accepted')
    self.save!
  end

  def leave
    # Remove admin also on leave
    raise 'membership must be accepted to leave.' unless invite_status == 'accepted'
    self.update(invite_status: 'left', admin: false)
    self.save!
  end


  private

  def pending?
    raise 'membership must be pending.' unless invite_status == 'pending'
  end

end
