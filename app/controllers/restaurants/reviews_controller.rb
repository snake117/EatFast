class Restaurants::ReviewsController < ApplicationController
	include Reviewable
	
	before_action :set_reviewable

	private

		def set_reviewable
			@reviewable = Restaurant.friendly.find(params[:restaurant_id])
		end
end