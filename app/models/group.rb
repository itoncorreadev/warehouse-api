class Group < ApplicationRecord
  has_many :product, dependent: :destroy

  validates_presence_of :name
end
