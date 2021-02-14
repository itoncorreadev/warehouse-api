class Detail < ApplicationRecord
  belongs_to :product
  belongs_to :request

  validates_presence_of :product_id, :request_id, :quantity
end
