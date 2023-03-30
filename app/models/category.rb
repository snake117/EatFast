# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  ancestry       :string           not null
#  ancestry_depth :integer          default(0)
#  children_count :integer          default(0)
#  display_name   :string(100)      not null
#  name           :string(100)      not null
#  slug           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry  (ancestry)
#  index_categories_on_slug      (slug) UNIQUE
#
class Category < ApplicationRecord
  # include MeiliSearch::Rails

	extend FriendlyId
  # extend Pagy::Meilisearch
  extend Pagy::Searchkick

  # Broadcast changes in realtime with Hotwire
  # after_create_commit  -> { broadcast_prepend_later_to :categories, partial: "categories/index", locals: { category: self } }
  # after_update_commit  -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :categories, target: dom_id(self, :index) }

  has_many :restaurants

  friendly_id :display_name, use: :slugged

  searchkick word_start: [:name, :display_name], word_middle: [:name, :display_name], text_middle: [:name, :display_name]

  has_ancestry counter_cache: true, cache_depth: true

  # meilisearch do
  #   attribute :name
  #   attribute :display_name
  # end

  def search_data
    {
      name: name,
      display_name: display_name
    }
  end
end
