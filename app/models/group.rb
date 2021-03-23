class Group < ApplicationRecord

  #Associations
  has_many :products, dependent: :destroy
  has_many :categories, through: :products

  # Validations
  validates_presence_of :name

end
