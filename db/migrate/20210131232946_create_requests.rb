class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.datetime :date
      t.string :request_type
      t.string :document
      t.string :document_code
      t.integer :quantity
      t.float :unit_price
      t.float :total_price
      t.text :observation
      t.boolean :status, default: false
      t.references :product, foreign_key: true
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
