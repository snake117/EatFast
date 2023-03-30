# == Schema Information
#
# Table name: reviews
#
#  id                      :bigint           not null, primary key
#  user_id                 :bigint           not null
#  restaurant_id           :bigint           not null
#  title                   :string(125)      not null
#  food                    :decimal(2, 2)    default(0.0), not null
#  atmosphere              :decimal(2, 2)    default(0.0), not null
#  price                   :decimal(2, 2)    default(0.0), not null
#  speed                   :decimal(2, 2)    default(0.0), not null
#  overall                 :decimal(2, 2)    default(0.0), not null
#  recommend               :boolean          default(TRUE), not null
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

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
