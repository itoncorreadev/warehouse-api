# frozen_string_literal: true

class Supplier < ApplicationRecord

  has_many :requests

  validates_presence_of :description
end
