class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, limit: 100
      t.string :display_name, null: false, limit: 100

      # FriendlyID slug
      t.string :slug, index: { unique: true }

      # Ancestry gem
      t.string  :ancestry, collation: 'C', null: false, index: true
      t.integer :ancestry_depth, default: 0
      t.integer :children_count, default: 0

      t.timestamps
    end
  end
end
