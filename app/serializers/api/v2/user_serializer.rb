# frozen_string_literal: true

module Api
  module V2
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :name, :email, :auth_token, :created_at, :updated_at
    end
  end
end
