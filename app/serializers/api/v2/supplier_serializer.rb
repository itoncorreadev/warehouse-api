# frozen_string_literal: true

module Api
  module V2
    class SupplierSerializer < ActiveModel::Serializer
      attributes :id, :description, :type_document, :document, :address, :phone, :comment, :created_at, :updated_at
    end
  end
end
