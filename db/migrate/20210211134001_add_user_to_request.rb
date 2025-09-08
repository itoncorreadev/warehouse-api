# frozen_string_literal: true

class AddUserToRequest < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :user, foreign_key: true
  end
end
