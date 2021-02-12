class Product < ApplicationRecord
  belongs_to :group
  belongs_to :category

  validates_presence_of :name, :group_id
end
