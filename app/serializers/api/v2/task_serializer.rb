# frozen_string_literal: true

module Api
  module V2
    class TaskSerializer < ActiveModel::Serializer
      attributes :id, :title, :description, :done, :deadline, :user_id, :created_at, :updated_at, :short_description,
                 :is_late, :deadline_to_br, :done_description, :user

      def short_description
        object.description[0..40] if object.description.present?
      end

      def is_late
        Time.current > object.deadline if object.deadline.present?
      end

      def deadline_to_br
        I18n.l(object.deadline, format: :datetime) if object.deadline.present?
      end

      def done_description
        return 'Feita' if object.done

        'Pendente'
      end
    end
  end
end
