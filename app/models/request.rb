class Request < ApplicationRecord
  belongs_to :department, optional: true
  belongs_to :supplier, optional: true
  belongs_to :user

  validates_presence_of :description, :user_id
end
