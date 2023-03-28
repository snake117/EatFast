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
	puts "\tCreated user: #{create_user}"
end
puts "------END: Users------"

require 'active_support/core_ext/string/inflections.rb'

puts "------BEGIN: Categories------"
categories = [
	"Restaurants", "Nightlife", "Bars", "American", "Burgers", "Food", "American",
	"Breakfast & Brunch", "Pizza", "Cocktail Bars", "Sports Bars", "Fast Food", "Coffee & Tea",
	"Seafood", "Diners", "Pubs", "Sandwiches", "Mediterranean", "Arts & Entertainment",
	"Steakhouses", "Chicken Wings", "Delis", "Event Planning & Services", "Italian", "Salad",
	"Greek", "Barbeque", "Beer Bar", "Breweries", "Food Trucks", "Hot Dogs",
	"Middle Eastern", "Cafes", "Lounges", "Mexican", "Specialty Food",
	"Vegan", "Venues & Event Spaces", "Desserts", "Food Delivery Services", "Gastropubs",
	"Juice Bars & Smoothies", "Music Venues", "Tapas/Small Plates", "Wine Bars", "Canadian (New)",
	"Chinese", "Convenience Stores", "Meat Shops", "Soul Food", "Sushi Bars",
	"Vegetarian", "Asian Fusion", "Brewpubs", "Caterers", "Chicken Shop", "Comfort Food",
	"Dance Clubs", "Food Court", "French", "Halal", "Hotels", "Hotels & Travel",
	"Irish Pub", "Lebanese", "Social Clubs", "Soup", "Southern"
]

categories.each do |category|
	create_category = Category.create!(name: category.parameterize, display_name: category)
	puts "Category created: #{create_category.display_name} [#{create_category.name}]!"
end
puts "------END: Categories------"
