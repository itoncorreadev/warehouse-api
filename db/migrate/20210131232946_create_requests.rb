class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.datetime :date
      t.string :request_type
      t.string :description
      t.string :document_type
      t.string :document_code
      t.boolean :status, default: true
      t.references :product, foreign_key: true
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
