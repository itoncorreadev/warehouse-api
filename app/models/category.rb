class Category < ApplicationRecord
  has_many :product

  validates_presence_of :description
end
