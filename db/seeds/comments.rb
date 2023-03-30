puts "------BEGIN: Comments------"

# Comments for restaurants
restaurants = Restaurant.all

customers = User.all.where(business_owner: false)

restaurants.each do |restaurant|
	puts "#{restaurant.name}"

	number_of_comments = rand(3..23)

	number_of_comments.times do
		random_user = customers.sample

		create_comment = restaurant.comment.build.(
				user_id: random_user.id,
				commentable: restaurant,
				body: Faker::Lorem.words(number: rand(7..30))
			)

		if create_comment.save!
			puts "\tComment created!"
		else
			puts "\tError: Failed to create comment!"
		end

	end # number_of_comments.times do
end

# Comments for reviews

puts "------BEGIN: Comments------"