# frozen_string_literal: true

class Department < ApplicationRecord

  has_many :requests


  validates_presence_of :description
end
