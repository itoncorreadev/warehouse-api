# frozen_string_literal: true

class Task < ApplicationRecord

  belongs_to :user

  validates_presence_of :title, :user_id
end
