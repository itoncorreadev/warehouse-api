class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.integer :quantity
      t.float :unit_price
      t.float :total_price
      t.text :observation
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
