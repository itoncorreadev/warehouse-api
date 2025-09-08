# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :description
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
