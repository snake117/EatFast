# == Schema Information
#
# Table name: restaurants
#
#  id                      :bigint           not null, primary key
#  cached_votes_down       :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  claimed                 :boolean          default(FALSE), not null
#  cuisine                 :string(200)      not null
#  description             :text             not null
#  email                   :string(100)      not null
#  favoritable_score       :text
#  favoritable_total       :text
#  hours                   :jsonb
#  name                    :string(200)      not null
#  phone                   :string(20)       not null
#  price_range             :integer          not null
#  slug                    :string           not null
#  website                 :string(200)      not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  category_id             :bigint           not null
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_restaurants_on_category_id  (category_id)
#  index_restaurants_on_cuisine      (cuisine)
#  index_restaurants_on_name         (name)
#  index_restaurants_on_price_range  (price_range)
#  index_restaurants_on_slug         (slug) UNIQUE
#  index_restaurants_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
