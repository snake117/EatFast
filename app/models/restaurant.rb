# == Schema Information
#
# Table name: restaurants
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  category_id :bigint           not null
#  name        :string(200)      not null
#  description :text             not null
#  price_range :integer          not null
#  claimed     :boolean          default(FALSE), not null
#  email       :string(100)      not null
#  phone       :string(20)       not null
#  website     :string(200)      not null
#  hours       :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Restaurant < ApplicationRecord
  extend FriendlyId
  extend Pagy::Searchkick

  belongs_to :user
  belongs_to :category

  has_one_attached :logo
  has_one_attached :banner

  # Broadcast changes in realtime with Hotwire
  # after_create_commit  -> { broadcast_prepend_later_to :brands, partial: "restaurants/index", locals: { brand: self } }
  # after_update_commit  -> { broadcast_replace_later_to self }
  # after_destroy_commit -> { broadcast_remove_to :brands, target: dom_id(self, :index) }

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
