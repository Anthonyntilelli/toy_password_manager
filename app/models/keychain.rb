class Keychain < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 200 }
  validates :name, format: { without: /~/, message: '~ is reserved.' }, unless: -> { personal }
  validates :name, format: { with: /~\d+/, message: 'personal keychains are ~user_id' }, if: -> { personal }
  validates :personal, inclusion: { in: [true, false] } # Ensure boolean

  after_validation :normalize_name

  private

  def normalize_name
    self.name = name.downcase.titleize
  end
end
