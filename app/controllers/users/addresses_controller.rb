class Users::AddressesController < ApplicationController
	before_action :set_addressable

	private

		def set_commentable
			@addressable = Address.friendly.find(params[:user_id])
		end
end