# == Schema Information
#
# Table name: menu_items
#
#  id                      :bigint           not null, primary key
#  ancestry                :string           not null
#  ancestry_depth          :integer          default(0)
#  cached_votes_down       :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_total      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  children_count          :integer          default(0)
#  description             :text             not null
#  favoritable_score       :text
#  favoritable_total       :text
#  name                    :string(150)      not null
#  price_cents             :integer          default(0), not null
#  price_currency          :string           default("USD"), not null
#  slug                    :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  category_id             :bigint           not null
#  restaurant_id           :bigint           not null
#
# Indexes
#
#  index_menu_items_on_ancestry       (ancestry)
#  index_menu_items_on_category_id    (category_id)
#  index_menu_items_on_restaurant_id  (restaurant_id)
#  index_menu_items_on_slug           (slug)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (restaurant_id => restaurants.id)
#
FactoryBot.define do
  factory :menu_item do
    restaurant { nil }
    category { nil }
    name { "MyString" }
    description { "MyText" }
    price { 1 }
    image { nil }
  end
end
