# == Schema Information
#
# Table name: reviews
#
#  id                      :bigint           not null, primary key
#  atmosphere              :decimal(, )      default(0.0), not null
#  cached_votes_down       :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  favoritable_score       :text
#  favoritable_total       :text
#  food                    :decimal(, )      default(0.0), not null
#  overall                 :decimal(, )      default(0.0), not null
#  price                   :decimal(, )      default(0.0), not null
#  recommend               :boolean          default(TRUE), not null
#  reviewable_type         :string           not null
#  slug                    :string           not null
#  speed                   :decimal(, )      default(0.0), not null
#  title                   :string(125)      not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  reviewable_id           :bigint           not null
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_reviews_on_reviewable  (reviewable_type,reviewable_id)
#  index_reviews_on_slug        (slug) UNIQUE
#  index_reviews_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
