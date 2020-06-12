# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# Also Test normalize

Account.destroy_all
Membership.destroy_all
User.destroy_all
Keychain.destroy_all

# Users
puts 'User 1'
User.create!(name: 'John Doe', email: 'admin_accepted@test.example.com',
             email_confirmation: 'admin_accepted@test.example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 2'
User.create!(name: 'JOHN potteR', email: 'admin_decline@test.example.com',
             email_confirmation: 'admin_decline@test.example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 3'
User.create!(name: 'ROBERT Job', email: 'user_accepted@test.example.com',
             email_confirmation: 'user_accepted@test.example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 4'
User.create!(name: 'MICHAEL Octal', email: 'user_decline@test.example.com',
             email_confirmation: 'user_decline@test.example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 5'
User.create!(name: 'WILLIAM Doe', email: 'admin_pending@test.example.com',
             email_confirmation: 'admin_pending@test.example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 6'
User.create!(name: 'DAVID Graves', email: 'standard_pending@test.example.com',
             email_confirmation: 'standard_pending@test.example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 7'
User.create!(name: 'RICHARD Summer', email: 'RICHARD.Summer@example.com', email_confirmation: 'RICHARD.Summer@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 8'
User.create!(name: 'CHARLES Winter', email: 'CHARLES.Winter@example.com', email_confirmation: 'CHARLES.Winter@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 9'
User.create!(name: 'JOSEPH Fall', email: 'JOSEPH.Fall@definitely-real-outlook.com', email_confirmation: 'JOSEPH.Fall@definitely-real-outlook.com', password: 'password123', password_confirmation: 'password123')
puts 'User 10'
User.create!(name: 'THOMAS Apa', email: 'THOMAS.Apa@example.com', email_confirmation: 'THOMAS.Apa@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 11'
User.create!(name: 'CHRISTOPHER Nova', email: 'CHRISTOPHER.Nova@fakegoogle.net', email_confirmation: 'CHRISTOPHER.Nova@fakegoogle.net', password: 'password123', password_confirmation: 'password123')
puts 'User 12'
User.create!(name: 'DANIEL potteR', email: 'DANIEL.potteR@definitely-real-outlook.com', email_confirmation: 'DANIEL.potteR@definitely-real-outlook.com', password: 'password123', password_confirmation: 'password123')
puts 'User 13'
User.create!(name: 'PAUL Doe', email: 'PAUL.Doe@potato.org', email_confirmation: 'PAUL.Doe@potato.org', password: 'password123', password_confirmation: 'password123')
puts 'User 14'
User.create!(name: 'MARK Summer', email: 'MARK.Summer@example.com', email_confirmation: 'MARK.Summer@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 15'
User.create!(name: 'DONALD SPLIT', email: 'DONALD.SPLIT@fakegoogle.net', email_confirmation: 'DONALD.SPLIT@fakegoogle.net', password: 'password123', password_confirmation: 'password123')
puts 'User 16'
User.create!(name: 'MARY Smith', email: 'MARY.Smith@potato.org', email_confirmation: 'MARY.Smith@potato.org', password: 'password123', password_confirmation: 'password123')
puts 'User 17'
User.create!(name: 'PATRICIA potteR', email: 'PATRICIA.potteR@example.com', email_confirmation: 'PATRICIA.potteR@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 18'
User.create!(name: 'LINDA Summer', email: 'LINDA.Summer@fakegoogle.net', email_confirmation: 'LINDA.Summer@fakegoogle.net', password: 'password123', password_confirmation: 'password123')
puts 'User 19'
User.create!(name: 'BARBARA Smith', email: 'BARBARA.Smith@potato.org', email_confirmation: 'BARBARA.Smith@potato.org', password: 'password123', password_confirmation: 'password123')
puts 'User 20'

# Keychain
puts 'Keychain 1'
Keychain.create!(name: 'Epic Keychain')
puts 'Keychain 2'
Keychain.create!(name: 'Keychain 2')
puts 'Keychain 3'
Keychain.create!(name: 'Keychain 3')
puts 'Keychain 4'
Keychain.create!(name: 'Keychain 4')
puts 'Keychain 5'
Keychain.create!(name: 'Keychain 5')
puts 'Keychain 6'
Keychain.create!(name: 'BAHHHHH!')
puts 'Keychain 7'
Keychain.create!(name: 'Secret')
puts 'Keychain 8'
Keychain.create!(name: 'Learn.co')
puts 'Keychain 9'
Keychain.create!(name: 'Flatiron')
puts 'Keychain 10'
Keychain.create!(name: 'example')

# Membership
user_pool = User.all
Keychain.all.each do |kc|
  puts "Setting Membership for #{kc.name}"
  kc.invite(user_pool[0], true).accept
  kc.invite(user_pool[1], true).decline
  kc.invite(user_pool[2], false).accept
  kc.invite(user_pool[3], false).decline
  kc.invite(user_pool[4], true) # pending
  kc.invite(user_pool[5], false) # pending

  # User leaves start
  leaving_user = kc.invite(user_pool[6], true)
  leaving_user.accept
  leaving_user.leave
  # User leaves stop
end

# Accounts
Keychain.all.each do |kc|
  puts "Setting up accounts for #{kc.name}"
  Account.create!(name: "#{kc.name}-account-1", keychain: kc, url: 'www.example1.com', username: 'Fran', password: "qwerty")
  Account.create!(name: "#{kc.name}-account-2", keychain: kc, url: 'www.example2.com', username: 'Bill', password: "Fygars-pookas")
  Account.create!(name: "#{kc.name}-account-3", keychain: kc, url: 'www.example3.com', username: 'Dig_dug', password: "Fygars-pookas")
  Account.create!(name: "#{kc.name}-account-4", keychain: kc, url: 'www.example4.com', username: 'Hydra', password: "Red_skill_rules!")
  Account.create!(name: "#{kc.name}-account-5", keychain: kc, url: 'www.example5.com', username: 'Auto', password: "Super_car123")
end
