# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create admin users

# Admins
admin_names = {
	neema: {
		email: "nsadry@med.wayne.edu",
		first_name: "Neema",
		last_name: "Sadry",
		full_name: "Neema Sadry",
		gender: 1
	},
	adrian: {
		email: "adriantarnowski@wayne.edu",
		first_name: "Adrian",
		last_name: "Tarnowski",
		full_name: "Adrian Tarnowski",
		gender: 1
	},
	geetanjali: {
		email: "geetkul@wayne.edu",
		first_name: "Geetanjali",
		last_name: "Kulkarni",
		full_name: "Geetanjali Kulkarni",
		gender: 0
	},
	mario: {
		email: "Mario1118@wayne.edu",
		first_name: "Mario",
		last_name: "Ibrahim",
		full_name: "Mario Ibrahim",
		gender: 1
	}
}

admin_names.each do |key, values|
	admin_avatar_filename = "admin-#{values[:first_name].downcase}-avatar"
	admin_avatar_url = Faker::Avatar.image(slug: admin_avatar_filename, size: "300x300", format: "jpg")

	admin_avatar = {
		io: URI.parse(admin_avatar_url).open,
		filename: admin_avatar_filename,
		content_type: "image/jpg"
	}

	User.create!(
		email: values[:email],
		password: "#{values[:first_name].downcase}admin",
		username: values[:full_name].gsub(/\s+/, "").downcase,
		first_name: values[:first_name],
		last_name: values[:last_name],
		country_code: "US",
		time_zone: "Eastern Time (US & Canada)",
		gender: values[:gender],
		birthday: Faker::Date.birthday(min_age: 22, max_age: 32),
		admin: true
	).avatar.attach(admin_avatar)
end

# Create regular users with male gender
# 15.times do
# 	user_first_name = Faker::Name.male_first_name

# 	user_avatar_filename = "admin-#{user_first_name.downcase}-avatar"
# 	admin_neema_avatar_url = Faker::Avatar.image(slug: user_avatar_filename, size: "300x300", format: "jpg")

# 	admin_neema_avatar_hash = {
# 		io: URI.parse(admin_neema_avatar_url).open,
# 		filename: "#{user_avatar_filename}.jpg",
# 		content_type: "image/jpg"
# 	}

# 	create_admin_neema = User.create!(
# 		email: Faker::Internet.email,
# 		password: "password",
# 		username: Faker::Internet.username(name: user_first_name),
# 		first_name: user_first_name,
# 		last_name: Faker::Name.last_name,
# 		country_code: Faker.Address.country_code,
# 		time_zone: Faker::Address.time_zone,
# 		gender: 1,
# 		birthday: Faker::Date.birthday(min_age: 25, max_age: 35),
# 		admin: true
# 	)

# 	create_admin_neema.avatar.attach(admin_neema_avatar_hash)
# end