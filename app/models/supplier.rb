class Supplier < ApplicationRecord

  #Associations
  has_many :requests

  #Validations
  validates_presence_of :description

end
