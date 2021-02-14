class Supplier < ApplicationRecord
  has_many :requests

  validates_presence_of :description
end
