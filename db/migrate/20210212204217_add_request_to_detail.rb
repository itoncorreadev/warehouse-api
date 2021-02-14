class AddRequestToDetail < ActiveRecord::Migration[5.0]
  def change
    add_reference :details, :request, foreign_key: true
  end
end
