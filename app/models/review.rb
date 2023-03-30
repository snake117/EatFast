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
class Review < ApplicationRecord
  # include MeiliSearch::Rails
  
  extend FriendlyId
  # extend Pagy::Meilisearch
  extend Pagy::Searchkick

  belongs_to :user
  belongs_to :restaurant
  belongs_to :reviewable, polymorphic: true

  has_many :comments, as: :commentable

  has_rich_text :body

  has_many_attached :images

  friendly_id :title, use: :slugged

  acts_as_favoritor
  acts_as_favoritable

  acts_as_voter

  searchkick word_start: [:title, :body], word_middle: [:title, :body], word_end: [:title, :body]

  after_create_commit do
    broadcast_append_to [reviewable, :reviews], target: "#{dom_id(reviewable)}_reviews" #, partial: "reviews/review_with_replies"
  end

  after_update_commit do
    broadcast_replace_to self
  end

  after_destroy_commit do
    broadcast_remove_to self
    broadcast_action_to self, action: :remove, target: "#{dom_id(self)}_with_reviews"
  end

  validates :title, presence: true
  validates :body, presence: true
  # validates :food, presence: true
  # validates :atmosphere, presence: true
  # validates :price, presence: true
  # validates :speed, presence: true
  # validates :overall, presence: true

  def search_data
    {
      title: title,
      body: body
    }
  end
end
