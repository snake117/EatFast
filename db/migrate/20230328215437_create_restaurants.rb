class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true, index: true

      t.string :name, null: false, limit: 200, index: true
      t.text :description, null: false, limit: 5000
      t.string :cuisine, null: false, limit: 200, index: true
      t.integer :price_range, null: false, numericality: true, index: true
      t.boolean :claimed, null: false, default: false
      t.string :email, null: false, limit: 100
      t.string :phone, null: false, limit: 20
      t.string :website, null: false, limit: 200
      t.jsonb :hours, null: true

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
