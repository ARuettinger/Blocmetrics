# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do
	user = User.create!(
		email: Faker::Internet.email,
		password: Faker::Internet.password(10)
		)
	users = User.all

	10.times do
		registered_application = RegisteredApplication.create!(
			user: user,
			name: Faker::App.name
			)
		10.times do
			event = Event.create!(
				name: Faker::Hipster.name
				)
		end
	end
end