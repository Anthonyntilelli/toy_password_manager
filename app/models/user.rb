class User < ApplicationRecord
  has_secure_password
  has_secure_password :reset_token, validations: false

  # TODO: prevent reset_token manual setting


  validates :name,
            presence: true,
            format: { with: /[A-Za-z]+\s[A-Za-z]+/,
                      message: 'Must be First and Last name' }
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


  # securlty generates and returns reset token
  def generate_reset_token
    # TODO Implement expiration system
    self.reset_token = SecureRandom.urlsafe_base64
  end

  # TODO: expand `authenticate_reset_token` method to consider expiration and wipe reset token when used.

  private

  def email_not_password
    errors.add(:password, 'must not equal email') if password.downcase == email.downcase
  end

  def normalize_enties
    self.name = name.titleize
    self. email = email.capitalize
  end
end
