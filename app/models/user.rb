# frozen_string_literal: true

# Validates and manages User
class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :keychains, through: :memberships

  has_secure_password

  before_validation :strip_name, on: %i[create update]
  before_update :change_password

  validates :name,
            presence: true,
            format: { with: /[A-Za-z]+\s[A-Za-z]+/,
                      message: 'must be First and Last name' }
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP },
            confirmation: true
  validates :email_confirmation, presence: true, if: -> { email_changed? }
  validates :password,
            presence: true,
            length: { minimum: 8 },
            if: -> { password_digest_changed? }
  validates :password_confirmation,
            presence: true,
            if: -> { password_digest_changed? }
  validate :email_not_password, if: -> { password_digest_changed? }

  after_validation :normalize_enties

  # list of key chain this user is a member of
  def last_member
    keychains.select { |kc| kc.active_members.count == 1 }
  end

  def self.create_oauth(name, email)
    # max size of has_secure_password is 72
    dummy_password = SecureRandom.hex(36)
    user = User.new(
      name: name, email: email, email_confirmation: email,
      password: dummy_password, password_confirmation: dummy_password,
      dummy_password: true
    )
    user.save!
    user
  end

  private

  # Remove dummy password status on password change
  def change_password
    self.dummy_password = false if password_digest_changed?
  end

  def email_not_password
    errors.add(:password, 'must not equal email') if password.downcase == email.downcase
  end

  def normalize_enties
    self.name = name.downcase.titleize
    self.email = email.capitalize
  end

  def strip_name
    self.name = name.strip
  end
end
