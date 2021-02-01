class Request < ApplicationRecord
  belongs_to :product
  belongs_to :department

  validates_presence_of :date, :type, :unit_price, :product_id, :department_id
end
