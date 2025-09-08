# frozen_string_literal: true

class AddSupplierToRequest < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :supplier, foreign_key: true
  end
end
