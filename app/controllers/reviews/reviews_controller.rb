class Reviews::ReviewsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_review

	def show
	end

	def edit
	end

	def update
		if @review.update(review_params)
			redirect_to @review
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@review.destroy

		respond_to do |format|
			format.turbo_stream {}
			format.html { redirect_to @review.reviewable }
		end
	end

	private

	def set_review
		@review = current_user.reviews.find(params[:id])
	end

	def review_params
		params.require(:review).permit(:title, :body, :food, :atmosphere, :price, :speed, :overall, :recommend, images: [])
	end
end