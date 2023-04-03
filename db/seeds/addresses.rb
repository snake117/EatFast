puts "------BEGIN: Addresses------"

users = User.all.where(business_owner: false)

users.each do |user|
	number_of_addresses = rand(1..6)
	# address_list = []

	number_of_addresses.times do
		user.addresses.build({
			addressable_id: user.id,
			addressable_type: "User",
			street_one: Faker::Address.street_address,
			street_two: Faker::Address.secondary_address,
			city: Faker::Address.city,
			state: Faker::Address.state_abbr,
			country: ["US", "CA"].sample, # Faker::Address.country_code
			zipcode: Faker::Address.zip_code,
			phone: Faker::PhoneNumber.cell_phone,
			email: Faker::Internet.email
		}).save!

		puts "\tAddress created!"
	end

	# user.addresses.create!(address_list)
end


restaurants = Restaurant.all

restaurants.each do |restaurant|
	restaurant.addresses.build({
		addressable_id: restaurant.id,
		addressable_type: "Restaurant",
		street_one: Faker::Address.street_address,
		street_two: Faker::Address.secondary_address,
		city: Faker::Address.city,
		state: Faker::Address.state_abbr,
		country: ["US", "CA"].sample, # Faker::Address.country_code
		zipcode: Faker::Address.zip_code,
		phone: Faker::PhoneNumber.cell_phone,
		email: Faker::Internet.email
	}).save!
	
	puts "\tAddress created!"
end




puts "------END: Addresses------"