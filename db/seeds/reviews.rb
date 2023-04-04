puts "------BEGIN: Reviews------"

# Reviews for restaurants
restaurants = Restaurant.all

customers = User.all.where(business_owner: false)

restaurants.each do |restaurant|
	puts "#{restaurant.name}"
	puts restaurant.inspect

	# number_of_reviews = rand(5..25)
	number_of_reviews = 7

	number_of_reviews.times do
		random_user = customers.sample

		create_review = restaurant.reviews.new(
				user_id: random_user.id,
				# reviewable_id: restaurant.id,
				# reviewable_type: restaurant,
				reviewable: restaurant,
				title: Faker::Lorem.words(number: rand(4..9)).join(' '),
				body: Faker::Lorem.paragraphs(number: rand(1..4)).join('/n'),
				food: rand(1..10),
				atmosphere: rand(1..10),
				price: rand(1..10),
				speed: rand(1..10),
				overall: rand(1..10),
				recommend: [true, false].sample,
			)

		if create_review.save!
			puts "\tReview created!"
		else
			puts "\tError: Failed to create review!"
		end

	end # number_of_reviews.times do
end

if Review.reindex
	puts "Review reindexed!"
else
	puts "Error: Failed to reindex review!"
end

puts "------BEGIN: Reviews------"