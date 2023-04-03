puts "------BEGIN: Users------"
puts "\t------BEGIN: Admins------"
admin_names = {
	neema: {
		email: "nsadry@med.wayne.edu",
		password: "neemaadmin",
		username: "neemasadry",
		first_name: "Neema",
		last_name: "Sadry",
		# full_name: "Neema Sadry",
		country_code: "US",
		time_zone: "Eastern Time (US & Canada)",
		gender: 1,
		birthday: Faker::Date.birthday(min_age: 22, max_age: 32),
		admin: true,
		business_owner: false
	},
	adrian: {
		email: "adriantarnowski@wayne.edu",
		password: "adrianadmin",
		username: "adriantarnowski",
		first_name: "Adrian",
		last_name: "Tarnowski",
		# full_name: "Adrian Tarnowski",
		country_code: "US",
		time_zone: "Eastern Time (US & Canada)",
		gender: 1,
		birthday: Faker::Date.birthday(min_age: 22, max_age: 32),
		admin: true,
		business_owner: false
	},
	geetanjali: {
		email: "geetkul@wayne.edu",
		password: "geetanjaliadmin",
		username: "geetanjalikulkarni",
		first_name: "Geetanjali",
		last_name: "Kulkarni",
		# full_name: "Geetanjali Kulkarni",
		country_code: "US",
		time_zone: "Eastern Time (US & Canada)",
		gender: 0,
		birthday: Faker::Date.birthday(min_age: 22, max_age: 32),
		admin: true,
		business_owner: false
	},
	mario: {
		email: "Mario1118@wayne.edu",
		password: "marioadmin",
		username: "marioibrahim",
		first_name: "Mario",
		last_name: "Ibrahim",
		# full_name: "Mario Ibrahim",
		country_code: "US",
		time_zone: "Eastern Time (US & Canada)",
		gender: 1,
		birthday: Faker::Date.birthday(min_age: 22, max_age: 32),
		admin: true,
		business_owner: false
	}
}

admin_names.each do |key, values|
	admin_avatar_filename = "admin-#{values[:first_name].downcase}-avatar"
	admin_avatar_url = Faker::Avatar.image(slug: admin_avatar_filename, size: "300x300", format: "jpg")
	down_obj = Down.download(admin_avatar_url, max_size: 6 * 1024 * 1024)


	admin_avatar = {
		io: File.open(down_obj),
		filename: down_obj.original_filename, # admin_avatar_filename,
		content_type: down_obj.content_type # "image/jpg"
	}

	User.create!(values).avatar.attach(admin_avatar)

	# puts "\tCreated user: #{create_user[:first_name]} #{create_user[:last_name]} [#{create_user[:username]}]!"
	puts "\t\tCreated user: #{key.to_s}!"
end
puts "\t------End: Admins------\n"


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
		io: URI.open(user_avatar_url),
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

if User.reindex
	puts "\n\tReindexed users!\n"
else
	puts "\n\tError: Failed to reindex users!\n"
end

puts "------END: Users------\n\n"