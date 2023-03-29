puts "------BEGIN: Users------"
puts "\t------BEGIN: Admins------"
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
		first_name: values[:first_name].downcase,
		last_name: values[:last_name].downcase,
		country_code: "US",
		time_zone: "Eastern Time (US & Canada)",
		gender: values[:gender],
		birthday: Faker::Date.birthday(min_age: 22, max_age: 32),
		admin: true,
		business_owner: false
	).avatar.attach(admin_avatar)

	# puts "\tCreated user: #{create_user[:first_name]} #{create_user[:last_name]} [#{create_user[:username]}]!"
	puts "\t\tCreated user: #{key}!"
end
puts "\t------End: Admins------"


25.times do
	random_num = rand(1..10)

	if random_num <= 5
		user_first_name = Faker::Name.male_first_name
		user_last_name = Faker::Name.last_name
		user_gender = 1
	elsif random_num >= 6
		user_first_name = Faker::Name.female_first_name
		user_last_name = Faker::Name.last_name
		user_gender = 0
	else
		puts "Error: random_num (#{random_num}) must be between integers 1..10."
	end
			
	user_avatar_filename = "#{user_first_name.downcase}-avatar"
	user_avatar_url = Faker::Avatar.image(slug: user_avatar_filename, size: "300x300", format: "jpg")

	user_avatar = {
		io: URI.parse(user_avatar_url).open,
		filename: user_avatar_filename,
		content_type: "image/jpg"
	}

	create_user_data = {
		email: Faker::Internet.email(name: "#{user_first_name}"),
		password: "#{user_first_name.downcase}password",
		username: Faker::Internet.username(specifier: "#{user_first_name} #{user_last_name}", separators: %w(_ -)).downcase,
		first_name: user_first_name.downcase,
		last_name: user_last_name.downcase,
		country_code: "US",
		time_zone: "Eastern Time (US & Canada)",
		gender: user_gender,
		birthday: Faker::Date.birthday(min_age: 16, max_age: 80),
		admin: false,
		business_owner: true
	}

	if User.create!(create_user_data).avatar.attach(user_avatar)
		puts "\tCreated user: #{create_user_data[:username]}!"
	else
		puts "\tError: Failed to create user - #{create_user_data[:username]}"
	end
end
puts "------END: Users------"