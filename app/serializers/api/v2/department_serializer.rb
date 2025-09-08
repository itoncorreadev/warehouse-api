# frozen_string_literal: true

module Api
  module V2
    class DepartmentSerializer < ActiveModel::Serializer
      attributes :description, :status, :created_at, :updated_at
    end
  end
end
