# frozen_string_literal: true

module Api
  module V2
    class ProductSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :code, :product_type, :measure, :min, :med, :max, :location, :status, :group_id,
                 :category_id, :quantity_in, :quantity_out, :quantity_inventory, :quantity_measure, :quantity_description, :created_at, :updated_at, :category, :group

      def quantity_in
        Detail.joins(:product, :request).where(product_id: object.id).where("request_type = 'in'").map(&:quantity).sum
      end

      def quantity_out
        Detail.joins(:product, :request).where(product_id: object.id).where("request_type = 'out'").map(&:quantity).sum
      end

      def quantity_inventory
        quantity_in - quantity_out
      end

      def quantity_measure
        if quantity_inventory.to_i <= object.min.to_i
          'danger'
        elsif quantity_inventory.to_i > object.min.to_i && quantity_inventory.to_i <= object.med
          'warning'
        elsif quantity_inventory.to_i > object.med.to_i && quantity_inventory.to_i <= object.max
          'success'
        else
          'info'
        end
      end

      def quantity_description
        case quantity_measure
        when 'danger'
          'Abaixo da mínima'
        when 'warning'
          'Acima da mínima'
        when 'success'
          'Acima da média'
        else
          'Acima da máxima'
        end
      end
    end
  end
end
