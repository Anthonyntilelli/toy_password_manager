# frozen_string_literal: true

# Manages and validate account for stored passwords
class Account < ApplicationRecord
  belongs_to :keychain

  validates :name, uniqueness: { scope: :keychain, message: 'is already taken in this keychain.' },
                   length: { maximum: 100 }
  validates :keychain, presence: true
  validates :url, presence: true
  validates :username, presence: true
  validates :password, presence: true
end
