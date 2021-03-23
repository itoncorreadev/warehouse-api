class Category < ApplicationRecord

  # Associations
  has_many :products
  has_many :groups, through: :products

  # Validations
  validates_presence_of :description

end
