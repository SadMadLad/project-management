# frozen_string_literal: true

#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create({ first_name: 'New', last_name: 'User', email: 'new@user.com', password: 'password' })
User.create({ first_name: 'NewTwo', last_name: 'UserTwo', email: 'new@user2.com',
password: 'password' })
User.create({ first_name: 'NewThree', last_name: 'UserThree', email: 'new@user3.com',
password: 'password' })
User.create({ first_name: 'NewFour', last_name: 'UserFour', email: 'new@user4.com',
password: 'password' })
