class Api::V2::GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :created_at, :updated_at
end
