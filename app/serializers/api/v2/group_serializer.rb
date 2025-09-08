# frozen_string_literal: true

module Api
  module V2
    class GroupSerializer < ActiveModel::Serializer
      attributes :id, :name, :status, :created_at, :updated_at
    end
  end
end
