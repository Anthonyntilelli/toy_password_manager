class User < ApplicationRecord
  has_secure_password

  before_validation :strip_name, on: [ :create, :update ]

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

  private

  def email_not_password
    errors.add(:password, 'must not equal email') if password.downcase == email.downcase
  end

  def normalize_enties
    self.name = name.downcase.titleize
    self.email = email.capitalize
  end

  def strip_name
    self.name = self.name.strip
  end
end
