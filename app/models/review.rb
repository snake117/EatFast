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
class Review < ApplicationRecord
  extend FriendlyId
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
