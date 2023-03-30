# == Schema Information
#
# Table name: restaurants
#
#  id                      :bigint           not null, primary key
#  user_id                 :bigint           not null
#  category_id             :bigint           not null
#  name                    :string(200)      not null
#  description             :text             not null
#  price_range             :integer          not null
#  claimed                 :boolean          default(FALSE), not null
#  email                   :string(100)      not null
#  phone                   :string(20)       not null
#  website                 :string(200)      not null
#  hours                   :jsonb
#  slug                    :string           not null
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  favoritable_score       :text
#  favoritable_total       :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
