class Product < ApplicationRecord
  belongs_to :group
  belongs_to :category

  has_many :details

  validates_presence_of :name, :group_id
end
