# frozen_string_literal: true

module Api
  module V2
    class CategorySerializer < ActiveModel::Serializer
      attributes :id, :description, :status, :created_at, :updated_at
    end
  end
end
