# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :code, default: '0'
      t.boolean :product_type, default: false
      t.string :measure, default: 'Un'
      t.integer :min, default: 10
      t.integer :med, default: 20
      t.integer :max, default: 30
      t.string :location
      t.boolean :status, default: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
