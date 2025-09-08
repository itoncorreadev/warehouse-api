# frozen_string_literal: true

class Request < ApplicationRecord

  belongs_to :department, optional: true
  belongs_to :supplier, optional: true
  belongs_to :user, optional: true

  validates_presence_of :description, :user_id
end
