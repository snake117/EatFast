puts "------BEGIN: Menu Items------"

restaurants = Restaurant.all
cuisines = Category.find_by(name: "cuisine").children
food_images = Dir[Rails.root.join('db', 'seeds', 'menu_items', '*.jpg')]

# number_of_menu_items = rand(12..45)
number_of_menu_items = 5

restaurants.each do |restaurant|
	puts "#{restaurant.name}"

	# image_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['food'])
	# down_obj = Down.download(image_url, max_size: 6 * 1024 * 1024)

	# image_data = {
	# 	io: File.open(down_obj),
	# 	filename: down_obj.original_filename, # admin_avatar_filename,
	# 	content_type: down_obj.content_type # "image/jpg"
	# }

	number_of_menu_items.times do 
		create_menu_item = MenuItem.create!(
			restaurant_id: restaurant.id,
			category_id: cuisines.sample.id,
			name: Faker::Food.dish,
			description: Faker::Food.description,
			price: Money.new(rand(0..500), :usd),
			# ingredient_list: [Faker::Food.ingredients, Faker::Food.sushi, Faker::Food.spice, Faker::Food.vegetables]
			# allergens: # Faker::Food.allergens
		)

		food_image_path = food_images.sample

		image_data = {
			io: File.open(food_image_path),
			filename: File.basename(food_image_path),
			content_type: "image/jpeg"
		}

		create_menu_item.image.attach(image_data)

		# create_menu_item.ingredient_list.add([Faker::Food.ingredients, Faker::Food.sushi, Faker::Food.spice, Faker::Food.vegetables]).save!

		puts "\tCreated menu item!" # : #{create_menu_item.name} [#{create_menu_item.price}]"
	end

end

puts "------END: Menu Items------"