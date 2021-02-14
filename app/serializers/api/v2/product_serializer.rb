class Api::V2::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :code, :product_type, :measure, :min, :med, :max, :location, :status, :group_id, :category_id, :created_at, :updated_at, :category, :group
end
