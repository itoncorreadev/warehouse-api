class Api::V2::SupplierSerializer < ActiveModel::Serializer
  attributes :id, :description, :type_document, :document, :address, :phone, :comment, :created_at, :updated_at
end
