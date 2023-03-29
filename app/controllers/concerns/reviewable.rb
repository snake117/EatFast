module Reviewable
	extend ActiveSupport::Concern
	include ActionView::RecordIdentifier
	include RecordHelper

	included do
		before_action :authenticate_user!
	end

	def create
		@review = @reviewable.reviews.new(review_params)
		@review.user = current_user
		@review.restaurant = @reviewable
		@review.parent_id = @parent&.id

		respond_to do |format|
			if @review.save
				review = Review.new
				format.turbo_stream {
					render turbo_stream: turbo_stream.replace(dom_id_for_records(@reviewable, review), partial: "reviews/form", locals: { review: review, reviewable: @reviewable })
				}
				format.html { redirect_to @reviewable }
			else
				format.turbo_stream {
					render turbo_stream.replace(dom_id_for_records(@reviewable, @review), partial: "reviews/form", locals: { review: @review, reviewable: @reviewable })
				}
				format.html { redirect_to @reviewable }
			end
		end
	end

	private

	def review_params
		params.require(:review).permit(:title, :body, :food, :atmosphere, :price, :speed, :overall, :recommend, images: [])
	end
end