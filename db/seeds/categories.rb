puts "------BEGIN: Categories------"
primary_business_category = Category.new(name: "business", display_name: "Business")

if primary_business_category.save!
	puts "\tCreated primary category: #{primary_business_category.display_name}"

	business_categories = {
		"Restaurants": [
			"Steakhouse", "Pizzeria", "Pop-up", "Ghost Kitchen", "Family", 
			"Casual Dining", "Fine Dining", "Bistro", "Contemporary Casual", "Teppanyaki Grill", 
			"Mongolian Barbecue", "Diner", "Buffet"
		],
		"Quick Service Restaurant (QSR)": ["Food Truck", "Food Stand", "Fast Food", "Cafeteria"],
		"Bars": ["Pub", "Cocktail Bar", "Sports Bar", "Brewpub", "Wine Bar", "Beer Bar", "Brewery", "Irish Pub", "Lounge"],
		"Cafes": ["Coffee Shop", "Tea House", "Juice & Smoothie"]
	}

	business_categories.each do |business_category_key, business_category_values|
		secondary_category = Category.new(name: business_category_key.to_s.singularize.parameterize, display_name: business_category_key.to_s, parent_id: primary_business_category.id)

		if secondary_category.save!
			puts "\t\tCreated secondary category: #{secondary_category.display_name}]!"

			business_category_values.each do |value|
				tertiary_category = Category.new(name: value.singularize.parameterize, display_name: value, parent_id: secondary_category.id)

				if tertiary_category.save!
					puts "\t\t\tCreated tertiary category: #{tertiary_category.display_name}}]!"
				else
					puts "\t\t\tError: Failed to create tertiary category: #{tertiary_category.display_name}}]!"
				end
			end # business_category_values.each do |value|

		else
			puts "\t\tError: Failed to create secondary business category!"
		end

	end # business_categories.each do |business_category|

else
	puts "\t\tError: Failed to create primary business category!"
end


cuisine_parent_category = Category.create!(name: "cuisine", display_name: "Cuisine")

cuisine_categories = [
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

cuisine_categories.each do |cuisine|
	create_cuisine = Category.create!(name: cuisine.singularize.parameterize, display_name: cuisine, parent_id: cuisine_parent_category.id)
	puts "\t\tCategory created: #{create_cuisine.display_name}]!"
end

if Category.reindex
	puts "\n\tReindexed categories!\n"
else
	puts "\n\tError: Failed to reindex categories!\n"
end

puts "------END: Categories------\n\n"
