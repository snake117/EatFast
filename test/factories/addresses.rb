# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string           not null
#  city             :string(100)      default(""), not null
#  country          :string(150)      default(""), not null
#  email            :string(100)      default("")
#  line_one         :string(100)      default(""), not null
#  line_two         :string(100)      default("")
#  phone            :string(25)       default(""), not null
#  state            :string(50)       default(""), not null
#  zipcode          :string(20)       default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :bigint           not null
#
# Indexes
#
#  index_addresses_on_addressable  (addressable_type,addressable_id)
#
FactoryBot.define do
  factory :address do
    addressable { nil }
    street_one { "MyString" }
    street_two { "MyString" }
    city { "MyString" }
    state { "MyString" }
    country { "MyString" }
    zipcode { "MyString" }
    phone { "MyString" }
    email { "MyString" }
  end
end
