class Supplier < ApplicationRecord
  has_many :request

  validates_presence_of :description
end
