class Restaurants::AddressesController < ApplicationController
	include Addressable
	before_action :set_addressable

	private

		def set_commentable
			@addressable = Address.find(params[:address_id])
		end
end