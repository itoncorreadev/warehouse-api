class Api::V2::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :auth_token, :created_at, :updated_at
end
