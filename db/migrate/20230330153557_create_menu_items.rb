class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.string :name, null: false, limit: 150
      
      t.text :description, null: false, limit: 3000
      
      t.monetize :price

      # Slug for FriendlyID
      t.string :slug, null: false, index: true

      # Caching for acts_as_votable
      t.integer :cached_votes_total, default: 0
      t.integer :cached_votes_score, default: 0
      t.integer :cached_votes_up, default: 0
      t.integer :cached_votes_down, default: 0
      t.integer :cached_weighted_score, default: 0
      t.integer :cached_weighted_total, default: 0
      t.float :cached_weighted_average, default: 0.0

      # acts_as_favoritable (acts_as_favoritor gem)
      t.text :favoritable_score
      t.text :favoritable_total

      # Ancestry gem
      t.string  :ancestry, collation: 'C', null: false, index: true
      t.integer :ancestry_depth, default: 0
      t.integer :children_count, default: 0

      t.timestamps
    end
  end
end
