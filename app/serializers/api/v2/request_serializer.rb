# frozen_string_literal: true

module Api
  module V2
    class RequestSerializer < ActiveModel::Serializer
      attributes :date, :request_type, :description, :document_type, :document_code, :status, :supplier_id, :user_id,
                 :department_id, :created_at, :updated_at, :date_to_br, :department, :supplier, :user, :status_description

      def date_to_br
        I18n.l(object.date, format: :datetime) if object.date.present?
      end

      def status_description
        return 'Concluída' if object.status

        'Pendente'
      end
    end
  end
end
