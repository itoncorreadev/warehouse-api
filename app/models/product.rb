class Product < ApplicationRecord
  belongs_to :group
  has_many :request, dependent: :destroy

  validates_presence_of :name, :group_id
end
