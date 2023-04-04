class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, null: false, index: true

      t.string :line_one, null: false, limit: 100, default: ""
      t.string :line_two, null: true, limit: 100, default: ""
      t.string :city, null: false, limit: 100, default: ""
      t.string :state, null: false, limit: 50, default: ""
      t.string :country, null: false, limit: 150, default: ""
      t.string :zipcode, null: false, limit: 20, default: ""
      t.string :phone, null: false, limit: 25, default: ""
      t.string :email, null: true, limit: 100, default: ""

      t.timestamps
    end
  end
end
