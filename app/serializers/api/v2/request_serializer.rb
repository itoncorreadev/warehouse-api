class Api::V2::RequestSerializer < ActiveModel::Serializer
  attributes :date, :request_type, :description, :document_type, :document_code, :observation, :status, :supplier_id, :product_id, :user_id, :department_id, :created_at, :updated_at, :date_to_br

  def date_to_br
    I18n.l(object.date, format: :datetime) if object.date.present?
  end
end
