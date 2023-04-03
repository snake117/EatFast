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
class Restaurant < ApplicationRecord
  # include MeiliSearch::Rails

  extend FriendlyId
  # extend Pagy::Meilisearch
  extend Pagy::Searchkick

  belongs_to :user
  belongs_to :category

  has_many :menu_items, dependent: :destroy

  # has_many :addresses, through: :addresses, as: :addressable, dependent: :destroy, inverse_of: :restaurant, source: :addresses
  has_many :addresses, as: :addressable
  has_many :addressable, through: :addresses
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true

  has_one_attached :logo
  has_one_attached :banner
  has_many_attached :images

  # Broadcast changes in realtime with Hotwire
  # after_create_commit  -> { broadcast_prepend_later_to :restaurants, partial: "restaurants/index", locals: { brand: self } }
  # after_update_commit  -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :restaurants, target: dom_id(self, :index) }

  friendly_id :name, use: :slugged

  acts_as_favoritor
  acts_as_favoritable

  acts_as_votable

  validates :name, presence: true, length: { minimum: 2, maximum: 80 }
  validates :description, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :cuisine, presence: true, length: { minimum: 2, maximum: 150 }
  validates :price_range, presence: true, numericality: { only_integer: true }

  validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 100 }
  validates :phone,         allow_blank: true, length: { minimum: 4, maximum: 20 }
  validates :website,       allow_blank: true, length: { minimum: 4, maximum: 150 }

  validates_associated :addresses

  # meilisearch do
  #   attribute :name
  #   attribute :description
  #   attribute :cuisine
    
  #   filterable_attributes [:cuisine]
  #   sortable_attributes [:price_range, :created_at, :updated_at]
  # end

  searchkick word_start: [:name, :category, :price_range], word_middle: [:name, :category], text_middle: [:name, :category]

  def search_data
    {
      name: name,
      category: category.name,
      price_range: price_range.to_s
    }
  end
end
