class Group < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :categories, through: :products

  validates_presence_of :name
end
