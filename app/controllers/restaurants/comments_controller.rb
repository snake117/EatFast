class Restaurants::CommentsController < ApplicationController
	include Commentable
	before_action :set_commentable

	private

		def set_commentable
			@commentable = Restaurant.friendly.find(params[:restaurant_id])
		end
end