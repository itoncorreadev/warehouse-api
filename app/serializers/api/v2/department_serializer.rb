class Api::V2::DepartmentSerializer < ActiveModel::Serializer
  attributes :description, :status, :created_at, :updated_at
end
