class CreateSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :suppliers do |t|
      t.string :description
      t.string :type_document
      t.string :document
      t.string :address
      t.string :phone
      t.text :comment
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
