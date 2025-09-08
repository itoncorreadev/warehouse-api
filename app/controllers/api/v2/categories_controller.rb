# frozen_string_literal: true

module Api
  module V2
    class CategoriesController < Api::V2::BaseController
      before_action :authenticate_user!

      def index
        categories = Category.ransack(params[:q]).result

        render json: categories, status: 200
      end

      def show
        category = Category.find(params[:id])

        render json: category, status: 200
      end

      def create
        category = Category.new(category_params)

        if category.save
          render json: category, status: 201
        else
          render json: { errors: category.errors }, status: 422
        end
      end

      def update
        category = Category.find(params[:id])

        if category.update_attributes(category_params)
          render json: category, status: 200
        else
          render json: { errors: category.errors }, status: 422
        end
      end

      def destroy
        category = Category.find(params[:id])
        category.destroy
        head 204
      end

      private

      def category_params
        params.require(:category).permit(:description, :status)
      end
    end
  end
end
