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
require "test_helper"

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
