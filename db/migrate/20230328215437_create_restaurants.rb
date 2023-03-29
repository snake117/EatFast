class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true, index: true

      t.string :name, null: false, limit: 200, index: true
      t.text :description, null: false, limit: 5000
      t.integer :price_range, null: false, numericality: true, index: true
      t.boolean :claimed, null: false, default: false
      t.string :email, null: false, limit: 100
      t.string :phone, null: false, limit: 20
      t.string :website, null: false, limit: 200
      t.jsonb :hours, null: true

      t.string :slug, null: false, default: ""

      t.timestamps
    end
  end
end
