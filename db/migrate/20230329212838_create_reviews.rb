class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.string :title, null: false, limit: 125
      
      # Ratings
      t.decimal :food, precision: 2, scale: 2, null: false, default: 0.0
      t.decimal :atmosphere, precision: 2, scale: 2, null: false, default: 0.0
      t.decimal :price, precision: 2, scale: 2, null: false, default: 0.0
      t.decimal :speed, precision: 2, scale: 2, null: false, default: 0.0
      t.decimal :overall, precision: 2, scale: 2, null: false, default: 0.0

      t.boolean :recommend, null: false, default: true

      # Slug for FriendlyID
      t.string :slug, null: false, index: { unique: true }

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

      t.timestamps
    end
  end
end
