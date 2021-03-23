class Detail < ApplicationRecord

  #Associations
  belongs_to :product
  belongs_to :request

  # Validations
  validates_presence_of :product_id, :request_id, :quantity

end
