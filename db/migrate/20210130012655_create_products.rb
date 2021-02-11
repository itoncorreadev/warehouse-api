class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :code
      t.boolean :product_type, default: false
      t.string :measure
      t.integer :min
      t.integer :med
      t.integer :max
      t.string :location
      t.boolean :status, default: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
