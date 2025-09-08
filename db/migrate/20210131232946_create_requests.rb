# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.datetime :date, default: DateTime.now
      t.string :request_type
      t.string :description
      t.string :document_type, default: 'NF'
      t.string :document_code, default: '0'
      t.boolean :status, default: false
      t.references :product, foreign_key: true
      t.references :department, foreign_key: true

      t.timestamps
    end
  end
end
