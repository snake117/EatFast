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
class Restaurant < ApplicationRecord
  extend FriendlyId
  extend Pagy::Searchkick

  belongs_to :user
  belongs_to :category

  has_many :menu_items

  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable

  has_one_attached :logo
  has_one_attached :banner
  has_many_attached :images

  # Broadcast changes in realtime with Hotwire
  after_create_commit  -> { broadcast_prepend_later_to :restaurants, partial: "restaurants/index", locals: { brand: self } }
  after_update_commit  -> { broadcast_replace_later_to self }
  after_destroy_commit -> { broadcast_remove_to :restaurants, target: dom_id(self, :index) }

  friendly_id :name, use: :slugged

  acts_as_favoritor
  acts_as_favoritable
  acts_as_votable

  searchkick word_start: [:name, :category, :price_range], word_middle: [:name, :category], text_middle: [:name, :category]

  validates :name, presence: true, length: { minimum: 2, maximum: 80 }
  validates :description, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :price_range, presence: true, numericality: { only_integer: true }
  validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 100 }
  validates :phone,         allow_blank: true, length: { minimum: 4, maximum: 20 }
  validates :website,       allow_blank: true, length: { minimum: 4, maximum: 150 }

  def search_data
    {
      name: name,
      category: category.name,
      price_range: price_range.to_s
    }
  end
end
