class ApplicationController < ActionController::Base
	include Pundit::Authorization
  include Pagy::Backend

	before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :country_code, :time_zone, :gender, :birthday, addresses_attributes: [:id, :street_one, :street_two, :city, :state, :country, :zipcode, :phone, :email]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name, :country_code, :time_zone, :gender, :birthday, addresses_attributes: [:id, :street_one, :street_two, :city, :state, :country, :zipcode, :phone, :email]])
  end
end
