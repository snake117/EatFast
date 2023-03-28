# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "------BEGIN: Users------"
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

	create_user = User.create!(
		email: values[:email],
		password: "#{values[:first_name].downcase}admin",
		username: values[:full_name].gsub(/\s+/, "").downcase,
		first_name: values[:first_name].downcase,
		last_name: values[:last_name].downcase,
		country_code: "US",
		time_zone: "Eastern Time (US & Canada)",
		gender: values[:gender],
		birthday: Faker::Date.birthday(min_age: 22, max_age: 32),
		admin: true
	).avatar.attach(admin_avatar)

	# puts "\tCreated user: #{create_user[:first_name]} #{create_user[:last_name]} [#{create_user[:username]}]!"
	puts "\tCreated user: #{}!"
end
puts "------END: Users------"




puts "------BEGIN: Categories------"
business_parent_category = Category.new(name: "business", display_name: "Business")

if business_parent_category.save!
	puts "\t#{business_parent_category.display_name} saved!"

	business_categories = [
		"Restaurants", "Steakhouses", "Food Trucks", "Cafes", "Diners", "Pubs",
		"Bars", "Cocktail Bars", "Sports Bars", "Juice Bars & Smoothies", "Brewpubs", "Wine Bars", "Beer Bar", "Breweries", "Irish Pub",
		"Fast Food", "Coffee & Tea", 
		"Lounges",
	]

	business_categories.each do |business_category|
		create_business_category = Category.new(name: business_category.singularize.parameterize, display_name: business_category, parent_id: business_parent_category.id)

		if create_business_category.save!
			puts "\t\tCreated: #{create_business_category.display_name} [#{create_business_category.name}]!"
		else
			puts "\t\tError: Failed to create business category!"
		end

	end # business_categories.each do |business_category|

else
	puts "\t\tError: Failed to create business parent category!"
end


restaurant_parent_category = Category.find_by(display_name: "Restaurants")

restaurant_categories = [
	"American", "Burgers", "Breakfast & Brunch", "Pizza",
	"Seafood", "Sandwiches", "Mediterranean", 
	"Chicken Wings", "Delis",  "Italian", "Salad",
	"Greek", "Barbeque", "Hot Dogs", 'Latin', "Thai", "Indian",
	"Middle Eastern",   "Mexican", "Specialty Food",
	"Vegan", "Desserts", "Tapas/Small Plates", "Canadian",
	"Chinese", "Convenience Stores", "Meat Shops", "Soul Food", "Sushi",
	"Vegetarian", "Asian Fusion", "Caterers", "Chicken Shop", "Comfort Food",
	"French", "Halal", "Lebanese", "Soup", "Southern"
]

restaurant_categories.each do |restaurant_category|
	create_restaurant_category = Category.create!(name: restaurant_category.singularize.parameterize, display_name: restaurant_category, parent_id: restaurant_parent_category.id)
	puts "\t\tCategory created: #{create_restaurant_category.display_name} [#{create_restaurant_category.name}]!"
end

puts "------END: Categories------"

# rails g scaffold Resaurant user:references category:references name description:text price_range:integer claimed
