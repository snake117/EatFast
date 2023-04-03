# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string           not null
#  city             :string(100)      default(""), not null
#  country          :string(150)      default(""), not null
#  email            :string(100)      default("")
#  phone            :string(25)       default(""), not null
#  state            :string(50)       default(""), not null
#  street_one       :string(100)      default(""), not null
#  street_two       :string(100)      default("")
#  zipcode          :string(20)       default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint           not null
#
# Indexes
#
#  index_addresses_on_addressable  (addressable_type,addressable_id)
#
class Address < ApplicationRecord
  # include MeiliSearch::Rails

  # extend FriendlyId
  # extend Pagy::Meilisearch
  extend Pagy::Searchkick

  belongs_to :addressable, polymorphic: true , inverse_of: :addressable #, class_name: "Address"

  # enum address_type: [:billing, :delivery, :business]

  searchkick word_start: [:street_one, :street_two, :city, :state, :country, :zipcode, :phone, :email],
             word_middle: [:street_one, :street_two, :city, :state, :country, :zipcode, :phone, :email],
             word_end: [:street_one, :street_two, :city, :state, :country, :zipcode, :phone, :email]

  validates :street_one, presence: true, length: { minimum: 3, maximum: 100 }
  validates :street_two, presence: false, length: { minimum: 0, maximum: 100 }
  validates :city, presence: true, length: { minimum: 3, maximum: 100 }
  validates :state, presence: true, length: { minimum: 2, maximum: 50 }
  validates :country, presence: true, length: { minimum: 2, maximum: 150 }
  validates :zipcode, presence: true, length: { minimum: 3, maximum: 20 }
  validates :phone, presence: true, length: { minimum: 7, maximum: 25 }
  validates :email, presence: true, length: { minimum: 3, maximum: 100 }

  def search_data
    {
      street_one: street_one,
      street_two: street_two,
      city: city,
      state: state,
      country: country,
      zipcode: zipcode,
      phone: phone,
      email: email
    }
  end
end
