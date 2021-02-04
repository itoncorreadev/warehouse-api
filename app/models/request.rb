class Request < ApplicationRecord
  belongs_to :product
  belongs_to :department, optional: true
  belongs_to :supplier, optional: true

  validates_presence_of :document, :product_id
end
