class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :description
      t.boolean :status

      t.timestamps
    end
  end
end
