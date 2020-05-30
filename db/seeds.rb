# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# Also Test normalize

Member.destroy_all
User.destroy_all
Group.destroy_all

# Users
puts "User 1"
User.create!(name: "John Doe", email: "JAMES.Doe@example.com", email_confirmation: "JAMES.Doe@example.com", password: "password123", password_confirmation: "password123")
puts "User 2"
User.create!(name: "JOHN potteR", email: "JOHN.potteR@fakegoogle.net",  email_confirmation: "JOHN.potteR@fakegoogle.net", password: "password123", password_confirmation: "password123")
puts "User 3"
User.create!(name: "ROBERT Job",  email: "ROBERT.Job@definitely-real-outlook.com", email_confirmation: "ROBERT.Job@definitely-real-outlook.com", password: "password123", password_confirmation: "password123")
puts "User 4"
User.create!(name: "MICHAEL Octal", email: "MICHAEL.Octal@example.com", email_confirmation: "MICHAEL.Octal@example.com", password: "password123", password_confirmation: "password123")
puts "User 5"
User.create!(name: "WILLIAM Doe",  email: "WILLIAM.Doe@fakegoogle.net", email_confirmation: "WILLIAM.Doe@fakegoogle.net", password: "password123", password_confirmation: "password123")
puts "User 6"
User.create!(name: "DAVID Graves",  email: "DAVID.Graves@definitely-real-outlook.com", email_confirmation: "DAVID.Graves@definitely-real-outlook.com", password: "password123", password_confirmation: "password123")
puts "User 7"
User.create!(name: "RICHARD Summer",  email: "RICHARD.Summer@example.com", email_confirmation: "RICHARD.Summer@example.com", password: "password123", password_confirmation: "password123")
puts "User 8"
User.create!(name: "CHARLES Winter",  email: "CHARLES.Winter@example.com", email_confirmation: "CHARLES.Winter@example.com", password: "password123", password_confirmation: "password123")
puts "User 9"
User.create!(name: "JOSEPH Fall",  email: "JOSEPH.Fall@definitely-real-outlook.com", email_confirmation: "JOSEPH.Fall@definitely-real-outlook.com", password: "password123", password_confirmation: "password123")
puts "User 10"
User.create!(name: "THOMAS Apa",  email: "THOMAS.Apa@example.com", email_confirmation: "THOMAS.Apa@example.com", password: "password123", password_confirmation: "password123")
puts "User 11"
User.create!(name: "CHRISTOPHER Nova",  email: "CHRISTOPHER.Nova@fakegoogle.net", email_confirmation: "CHRISTOPHER.Nova@fakegoogle.net", password: "password123", password_confirmation: "password123")
puts "User 12"
User.create!(name: "DANIEL potteR",  email: "DANIEL.potteR@definitely-real-outlook.com", email_confirmation: "DANIEL.potteR@definitely-real-outlook.com", password: "password123", password_confirmation: "password123")
puts "User 13"
User.create!(name: "PAUL Doe",  email: "PAUL.Doe@potato.org", email_confirmation: "PAUL.Doe@potato.org", password: "password123", password_confirmation: "password123")
puts "User 14"
User.create!(name: "MARK Summer",  email: "MARK.Summer@example.com", email_confirmation: "MARK.Summer@example.com", password: "password123", password_confirmation: "password123")
puts "User 15"
User.create!(name: "DONALD SPLIT",  email: "DONALD.SPLIT@fakegoogle.net", email_confirmation: "DONALD.SPLIT@fakegoogle.net", password: "password123", password_confirmation: "password123")
puts "User 16"
User.create!(name: "MARY Smith",  email: "MARY.Smith@potato.org", email_confirmation: "MARY.Smith@potato.org", password: "password123", password_confirmation: "password123")
puts "User 17"
User.create!(name: "PATRICIA potteR",  email: "PATRICIA.potteR@example.com", email_confirmation: "PATRICIA.potteR@example.com", password: "password123", password_confirmation: "password123")
puts "User 18"
User.create!(name: "LINDA Summer",  email: "LINDA.Summer@fakegoogle.net", email_confirmation: "LINDA.Summer@fakegoogle.net", password: "password123", password_confirmation: "password123")
puts "User 19"
User.create!(name: "BARBARA Smith",  email: "BARBARA.Smith@potato.org", email_confirmation: "BARBARA.Smith@potato.org", password: "password123", password_confirmation: "password123")
puts "User 20"
User.create!(name: "ELIZABETH potteR ",  email: "ELIZABETH.potteR@fakegoogle.net", email_confirmation: "ELIZABETH.potteR@fakegoogle.net", password: "password123", password_confirmation: "password123")
puts "User 21"
User.create!(name: "   JENNIFER Winter",  email: "JENNIFER.Winter@example.com", email_confirmation: "JENNIFER.Winter@example.com", password: "password123", password_confirmation: "password123")
puts "User 22"
User.create!(name: "MARIA Fall   ",  email: "MARIA.Fall@fakegoogle.net", email_confirmation: "MARIA.Fall@fakegoogle.net", password: "password123", password_confirmation: "password123")
puts "User 23"
User.create!(name: "SUSAN Smith",  email: "SUSAN.Smith@potato.org", email_confirmation: "SUSAN.Smith@potato.org", password: "password123", password_confirmation: "password123")
puts "User 24"
User.create!(name: "   MARGARET Spring   ",  email: "MARGARET.Spring@example.com", email_confirmation: "MARGARET.Spring@example.com", password: "password123", password_confirmation: "password123")
puts "User 25"
User.create!(name: "DOROTHY Smith",  email: "DOROTHY.Smith@fakegoogle.net", email_confirmation: "DOROTHY.Smith@fakegoogle.net", password: "password123", password_confirmation: "password123")
puts "User 26"
User.create!(name: "LISA Octal",  email: "LISA.Octal@potato.org", email_confirmation: "LISA.Octal@potato.org", password: "password123", password_confirmation: "password123")
puts "User 27"
User.create!(name: "NANCY Spring",  email: "NANCY.Spring@definitely-real-outlook.com", email_confirmation: "NANCY.Spring@definitely-real-outlook.com", password: "password123", password_confirmation: "password123")
puts "User 28"
User.create!(name: "KAREN Smith",  email: "KAREN.Smith@potato.org", email_confirmation: "KAREN.Smith@potato.org", password: "password123", password_confirmation: "password123")
puts "User 29"
User.create!(name: "BETTY potteR",  email: "BETTY.potteR@example.com", email_confirmation: "BETTY.potteR@example.com", password: "password123", password_confirmation: "password123")
puts "User 30"
User.create!(name: "HELEN Smith",  email: "HELEN.Smith@fakegoogle.net", email_confirmation: "HELEN.Smith@fakegoogle.net", password: "password123", password_confirmation: "password123")

# Groups
puts "Group 1"
Group.create!(name: "Epic Group", personal: false)
puts "Group 2"
Group.create!(name: "Group 2", personal: false)
puts "Group 3"
Group.create!(name: "Group 3", personal: false)
puts "Group 4"
Group.create!(name: "Group 4", personal: false)
puts "Group 5"
Group.create!(name: "group 5", personal: false)
puts "Group 6"
Group.create!(name: "BAHHHHH!", personal: false)
puts "Group 7"
Group.create!(name: "Secret", personal: false)
puts "Group 8"
Group.create!(name: "Learn.co", personal: false)
puts "Group 9"
Group.create!(name: "Flatiron", personal: false)
puts "Group 10"
Group.create!(name: "example", personal: false)

# Member
group_pool = Group.all.shuffle
group_pool.each do |group|
  puts "Setting Membership for #{group.name}"
  user_pool = User.all.shuffle
  Member.create!(user: user_pool[0], group: group, admin: true, invite_status: "accepted")
  Member.create!(user: user_pool[1], group: group, admin: true, invite_status: "declined")
  Member.create!(user: user_pool[2], group: group, admin: false, invite_status: "accepted")
  Member.create!(user: user_pool[3], group: group, admin: false, invite_status: "pending")
  Member.create!(user: user_pool[4], group: group, admin: false, invite_status: "declined")
end
