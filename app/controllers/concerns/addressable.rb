module Addressable
	extend ActiveSupport::Concern
	include ActionView::RecordIdentifier

	included do
		before_action :authenticate_user!
	end

	def create
		@address = @addressable.addresses.new(address_params)
		# @address.user = current_user

		respond_to do |format|
			if @address.save
				address = Comment.new
				format.turbo_stream {
					render turbo_stream: turbo_stream.replace(dom_id_for_records(@addressable, address), partial: "addresss/form", locals: { address: address, addressable: @addressable })
				}
				format.html { redirect_to @addressable }
			else
				format.turbo_stream {
					render turbo_stream.replace(dom_id_for_records(@addressable, @address), partial: "addresss/form", locals: { address: @address, addressable: @addressable })
				}
				format.html { redirect_to @addressable }
			end
		end
	end

	private

	def address_params
		params.require(:address).permit(:id, :street_one, :street_two, :city, :state, :country, :zipcode, :phone, :email)
	end
end