class Api::V2::DetailSerializer < ActiveModel::Serializer
  attributes :quantity, :unit_price, :total_price, :observation, :product_id, :request_id, :updated_at, :created_at, :product, :request
end
