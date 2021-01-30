class Api::V2::GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :status
end
