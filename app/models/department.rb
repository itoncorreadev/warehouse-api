class Department < ApplicationRecord
  has_many :request, dependent: :destroy

  validates_presence_of :description
end
