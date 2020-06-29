# frozen_string_literal: true

# Sets up Oauth for Github
raise 'Github Key is not set' if ENV['GITHUB_KEY'].nil? || ENV['GITHUB_KEY'] == '<setme>'
raise 'Github Secret is not set' if ENV['GITHUB_SECRET'].nil? || ENV['GITHUB_SECRET'] == '<setme>'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: 'user:email'
end
