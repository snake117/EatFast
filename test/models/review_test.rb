# == Schema Information
#
# Table name: reviews
#
#  id                      :bigint           not null, primary key
#  atmosphere              :decimal(2, 2)    default(0.0), not null
#  cached_votes_down       :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  favoritable_score       :text
#  favoritable_total       :text
#  food                    :decimal(2, 2)    default(0.0), not null
#  overall                 :decimal(2, 2)    default(0.0), not null
#  price                   :decimal(2, 2)    default(0.0), not null
#  recommend               :boolean          default(TRUE), not null
#  slug                    :string           not null
#  speed                   :decimal(2, 2)    default(0.0), not null
#  title                   :string(125)      not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  restaurant_id           :bigint           not null
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_reviews_on_restaurant_id  (restaurant_id)
#  index_reviews_on_slug           (slug) UNIQUE
#  index_reviews_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (restaurant_id => restaurants.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
