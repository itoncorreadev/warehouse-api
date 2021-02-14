class Api::V2::CategorySerializer < ActiveModel::Serializer
  attributes :id, :description, :status, :created_at, :updated_at
end
