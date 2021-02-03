class Api::V2::RequestSerializer < ActiveModel::Serializer
  attributes :date, :request_type, :document, :document_code, :quantity, :unit_price, :total_price, :observation, :status, :product_id, :department_id, :created_at, :updated_at, :date_to_br

  def date_to_br
    I18n.l(object.date, format: :datetime) if object.date.present?
  end
end
