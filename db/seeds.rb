# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# Also Test normalize

Account.destroy_all
Membership.destroy_all
User.destroy_all
Keychain.destroy_all

# Users
puts 'User 1'
User.create!(name: 'John Doe', email: 'JAMES.Doe@example.com', email_confirmation: 'JAMES.Doe@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 2'
User.create!(name: 'JOHN potteR', email: 'JOHN.potteR@fakegoogle.net', email_confirmation: 'JOHN.potteR@fakegoogle.net', password: 'password123', password_confirmation: 'password123')
puts 'User 3'
User.create!(name: 'ROBERT Job', email: 'ROBERT.Job@definitely-real-outlook.com', email_confirmation: 'ROBERT.Job@definitely-real-outlook.com', password: 'password123', password_confirmation: 'password123')
puts 'User 4'
User.create!(name: 'MICHAEL Octal', email: 'MICHAEL.Octal@example.com', email_confirmation: 'MICHAEL.Octal@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 5'
User.create!(name: 'WILLIAM Doe', email: 'WILLIAM.Doe@fakegoogle.net', email_confirmation: 'WILLIAM.Doe@fakegoogle.net', password: 'password123', password_confirmation: 'password123')
puts 'User 6'
User.create!(name: 'DAVID Graves', email: 'DAVID.Graves@definitely-real-outlook.com', email_confirmation: 'DAVID.Graves@definitely-real-outlook.com', password: 'password123', password_confirmation: 'password123')
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
User.create!(name: 'ELIZABETH potteR ', email: 'ELIZABETH.potteR@fakegoogle.net', email_confirmation: 'ELIZABETH.potteR@fakegoogle.net', password: 'password123', password_confirmation: 'password123')
puts 'User 21'
User.create!(name: '   JENNIFER Winter', email: 'JENNIFER.Winter@example.com', email_confirmation: 'JENNIFER.Winter@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 22'
User.create!(name: 'MARIA Fall   ', email: 'MARIA.Fall@fakegoogle.net', email_confirmation: 'MARIA.Fall@fakegoogle.net', password: 'password123', password_confirmation: 'password123')
puts 'User 23'
User.create!(name: 'SUSAN Smith', email: 'SUSAN.Smith@potato.org', email_confirmation: 'SUSAN.Smith@potato.org', password: 'password123', password_confirmation: 'password123')
puts 'User 24'
User.create!(name: '   MARGARET Spring   ', email: 'MARGARET.Spring@example.com', email_confirmation: 'MARGARET.Spring@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 25'
User.create!(name: 'DOROTHY Smith', email: 'DOROTHY.Smith@fakegoogle.net', email_confirmation: 'DOROTHY.Smith@fakegoogle.net', password: 'password123', password_confirmation: 'password123')
puts 'User 26'
User.create!(name: 'LISA Octal', email: 'LISA.Octal@potato.org', email_confirmation: 'LISA.Octal@potato.org', password: 'password123', password_confirmation: 'password123')
puts 'User 27'
User.create!(name: 'NANCY Spring', email: 'NANCY.Spring@definitely-real-outlook.com', email_confirmation: 'NANCY.Spring@definitely-real-outlook.com', password: 'password123', password_confirmation: 'password123')
puts 'User 28'
User.create!(name: 'KAREN Smith', email: 'KAREN.Smith@potato.org', email_confirmation: 'KAREN.Smith@potato.org', password: 'password123', password_confirmation: 'password123')
puts 'User 29'
User.create!(name: 'BETTY potteR', email: 'BETTY.potteR@example.com', email_confirmation: 'BETTY.potteR@example.com', password: 'password123', password_confirmation: 'password123')
puts 'User 30'
User.create!(name: 'HELEN Smith', email: 'HELEN.Smith@fakegoogle.net', email_confirmation: 'HELEN.Smith@fakegoogle.net', password: 'password123', password_confirmation: 'password123')

# Keychain
puts 'Keychain 1'
Keychain.create!(name: 'Epic Keychain', personal: false)
puts 'Keychain 2'
Keychain.create!(name: 'Keychain 2', personal: false)
puts 'Keychain 3'
Keychain.create!(name: 'Keychain 3', personal: false)
puts 'Keychain 4'
Keychain.create!(name: 'Keychain 4', personal: false)
puts 'Keychain 5'
Keychain.create!(name: 'Keychain 5', personal: false)
puts 'Keychain 6'
Keychain.create!(name: 'BAHHHHH!', personal: false)
puts 'Keychain 7'
Keychain.create!(name: 'Secret', personal: false)
puts 'Keychain 8'
Keychain.create!(name: 'Learn.co', personal: false)
puts 'Keychain 9'
Keychain.create!(name: 'Flatiron', personal: false)
puts 'Keychain 10'
Keychain.create!(name: 'example', personal: false)

# Membership
user_pool = User.all
Keychain.all.each do |kc|
  puts "Setting Membership for #{kc.name}"
  kc.invite(user_pool[0], true).accept
  kc.invite(user_pool[1], true).decline
  kc.invite(user_pool[2], false).accept
  kc.invite(user_pool[3], false) # pending (standard)
  kc.invite(user_pool[4], true) # pending (Admin)
  kc.invite(user_pool[5], false).decline
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
