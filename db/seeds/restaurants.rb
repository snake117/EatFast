puts "------BEGIN: Restaurants------"

restaurant_owners = User.where(business_owner: true, admin: false)
restaurant_subcategories = Category.find_by(display_name: "Restaurants").children

restaurant_logos = Dir[Rails.root.join('db', 'seeds', 'logos', '*')]
restaurant_banners = Dir[Rails.root.join('db', 'seeds', 'banners', '*')]

restaurant_owners.each do |restaurant_owner|
	start_hour = rand(7..11)
	end_hour =rand(9..11)

	create_restaurant_data = {
		user_id: restaurant_owner.id,
		category_id: restaurant_subcategories.sample.id,
		name: Faker::Restaurant.name,
		# category: Faker::Restaurant.type,
		price_range: rand(1..4),
		description: Faker::Restaurant.description,
		claimed: false,
		email: Faker::Internet.free_email(name: "#{restaurant_owner.first_name} #{restaurant_owner.last_name}"),
		phone: Faker::PhoneNumber.cell_phone,
		website: Faker::Internet.url,
		hours: {
			monday: 	 "#{start_hour}:00 AM - #{end_hour}:00 PM",
			tuesday: 	 "#{start_hour}:00 AM - #{end_hour}:00 PM",
			wednesday: "#{start_hour}:00 AM - #{end_hour}:00 PM",
			thursday:  "#{start_hour}:00 AM - #{end_hour}:00 PM",
			friday: 	 "#{start_hour}:00 AM - #{end_hour}:00 PM",
			saturday:  "#{start_hour}:00 AM - #{end_hour}:00 PM",
			sunday: 	 "#{start_hour}:00 AM - #{end_hour}:00 PM",
		}
	}

	create_restaurant = Restaurant.create!(create_restaurant_data)

	if create_restaurant
		puts "\tRestaurant created: #{create_restaurant_data[:name]}!"

		logo = restaurant_logos.sample
		restaurant_logo_data = {
			io: File.open(logo),
			filename: File.basename(logo),
			content_type: "image/png"
		}
		
		if create_restaurant.logo.attach(restaurant_logo_data)
			puts "\t\tLogo attached!"
		else
			puts "\t\tError: Logo failed to attach!"
		end

		banner = restaurant_banners.sample
		restaurant_banner_data = {
			io: File.open(banner),
			filename: File.basename(banner),
			content_type: "image/jpg"
		}
		
		if create_restaurant.banner.attach(restaurant_banner_data)
			puts "\t\tBanner attached!"
		else
			puts "\t\tError: Banner failed to attach!"
		end
	else
		puts "Error: Failed to create restaurant: #{create_restaurant}"
	end
end

puts "------END: Restaurants------"
