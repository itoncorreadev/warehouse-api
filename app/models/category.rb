class Category < ApplicationRecord
  has_many :products
  has_many :groups, through: :products

  validates_presence_of :description
end
