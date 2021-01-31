class Request < ApplicationRecord
  belongs_to :product
  belongs_to :department
end
