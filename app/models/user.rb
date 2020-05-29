class User < ApplicationRecord
  has_secure_password
  has_secure_password :reset_token, validations: false


# TODO: validation for user
# TODO: prevent reset_token manual setting
# TODO: method to generate reset_token

end
