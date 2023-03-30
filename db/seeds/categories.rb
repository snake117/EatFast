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

if Category.reindex
	puts "\n\tReindexed categories!\n"
else
	puts "\n\tError: Failed to reindex categories!\n"
end

puts "------END: Categories------"
