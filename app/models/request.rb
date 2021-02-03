class Request < ApplicationRecord
  belongs_to :product
  belongs_to :department, optional: true

  validates_presence_of :date, :product_id, :department_id
end
