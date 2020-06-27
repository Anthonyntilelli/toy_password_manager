# frozen_string_literal: true

# Sets up Oauth for Github
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: 'user:email'
end
