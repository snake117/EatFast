# == Schema Information
#
# Table name: menu_items
#
#  id                      :bigint           not null, primary key
#  cached_votes_down       :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  description             :text             not null
#  favoritable_score       :text
#  favoritable_total       :text
#  name                    :string(150)      not null
#  price_cents_cents       :integer          default(0), not null
#  price_cents_currency    :string           default("USD"), not null
#  slug                    :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  category_id             :bigint           not null
#  restaurant_id           :bigint           not null
#
# Indexes
#
#  index_menu_items_on_category_id    (category_id)
#  index_menu_items_on_restaurant_id  (restaurant_id)
#  index_menu_items_on_slug           (slug)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (restaurant_id => restaurants.id)
#
class MenuItem < ApplicationRecord
  # include MeiliSearch::Rails

  extend FriendlyId
  # extend Pagy::Meilisearch
  extend Pagy::Searchkick

  belongs_to :restaurant
  belongs_to :category

  has_one_attached :image

  friendly_id :name, use: :scoped, scope: [:restaurant]

  monetize :price_cents

  acts_as_taggable_on :ingredients
  acts_as_taggable_on :allergens

  acts_as_favoritor
  acts_as_favoritable

  acts_as_voter

  meilisearch do
    attribute :name
    attribute :description
    attribute :category
    attribute :price_range

    filterable_attributes [:category]
    sortable_attributes [:created_at, :updated_at]
  end

  searchkick searchable: [:name, :category],
             word_start: [:name, :description, :category], 
             word_middle: [:name, :description, :category], 
             word_end: [:name, :description, :category]

  def search_data
    {
      name: name,
      description: :description,
      category: category.display_name,
      price: price.to_s("F")
      # popularity: popularity
    }
  end
end
