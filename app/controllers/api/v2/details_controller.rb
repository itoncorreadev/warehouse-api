# frozen_string_literal: true

module Api
  module V2
    class DetailsController < Api::V2::BaseController
      before_action :authenticate_user!

      def index
        details = Detail.ransack(params[:q]).result.where(request_id: params[:request_id])

        render json: details, status: 200
      end

      def show
        detail = Detail.find_by(request_id: params[:request_id], id: params[:id])

        render json: detail, status: 200
      end

      def create
        request = Request.find(params[:request_id])
        product = Product.find(detail_params[:product_id])

        detail = Detail.new(detail_params)

        detail.request = request
        detail.product = product

        if detail.save
          render json: detail, status: 201
        else
          render json: { errors: detail.errors }, status: 422
        end
      end

      def update
        detail = Detail.find(params[:id])

        if detail.update_attributes(detail_params)
          render json: detail, status: 200
        else
          render json: { errors: detail.errors }, status: 422
        end
      end

      def destroy
        detail = Detail.find(params[:id])
        detail.destroy
        head 204
      end

      private

      def detail_params
        params.require(:detail).permit(:quantity, :unit_price, :total_price, :observation, :product_id)
      end
    end
  end
end
