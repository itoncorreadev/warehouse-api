class Group < ApplicationRecord
  has_many :products, dependent: :destroy

  validates_presence_of :name
end
