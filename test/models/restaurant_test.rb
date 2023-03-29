# == Schema Information
#
# Table name: restaurants
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  category_id :bigint           not null
#  name        :string(200)      not null
#  description :text             not null
#  price_range :integer          not null
#  claimed     :boolean          default(FALSE), not null
#  email       :string(100)      not null
#  phone       :string(20)       not null
#  website     :string(200)      not null
#  hours       :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
