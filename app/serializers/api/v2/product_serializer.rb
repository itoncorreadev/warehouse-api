class Api::V2::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :category, :code, :type, :measure, :min, :med, :max, :location, :status, :group_id, :created_at, :updated_at
end
