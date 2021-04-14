class Api::V2::DetailSerializer < ActiveModel::Serializer
  attributes :quantity, :unit_price, :total_price, :observation, :product_id, :request_id, :updated_at, :created_at, :product, :request, :calc_total_price_br, :unit_price_br

  def calc_total_price_br
    total = object.quantity * object.unit_price
    br = ActiveSupport::NumberHelper.number_to_currency(total)
    return br
  end

  def unit_price_br
    br = ActiveSupport::NumberHelper.number_to_currency(object.unit_price)
    return br
  end
end
