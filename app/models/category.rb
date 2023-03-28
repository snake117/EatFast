# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  name           :string(100)      not null
#  display_name   :string(100)      not null
#  slug           :string
#  ancestry       :string           not null
#  ancestry_depth :integer          default(0)
#  children_count :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Category < ApplicationRecord
	extend FriendlyId
  extend Pagy::Searchkick

  # Broadcast changes in realtime with Hotwire
  # after_create_commit  -> { broadcast_prepend_later_to :categories, partial: "categories/index", locals: { category: self } }
  # after_update_commit  -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :categories, target: dom_id(self, :index) }

  # has_many :products

  friendly_id :display_name, use: :slugged

  searchkick word_start: [:name, :display_name], word_middle: [:name, :display_name], text_middle: [:name, :display_name]

  has_ancestry counter_cache: true, cache_depth: true

  def search_data
    {
      name: name,
      display_name: display_name
    }
  end
end
