class Account < ApplicationRecord
  belongs_to :keychain

  validates :name, uniqueness: { scope: :keychain, message: 'is already taken in this keychain.' }, length: { maximum: 100 }
  validates :keychain, presence: true

  # TODO: Destroy mechanism
end
