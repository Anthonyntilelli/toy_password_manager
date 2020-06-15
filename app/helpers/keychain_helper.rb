# frozen_string_literal: true

# View heler for keychain
module KeychainHelper
  def keychain_admin?(keychain, user_id)
    keychain.memberships.find_by(user_id: user_id).admin
  end
end
