# frozen_string_literal: true

module Api
  module V2
    class DepartmentsController < Api::V2::BaseController
      before_action :authenticate_user!

      def index
        departments = Department.ransack(params[:q]).result

        render json: departments, status: 200
      end

      def show
        department = Department.find(params[:id])

        render json: department, status: 200
      end

      def create
        department = Department.new(department_params)

        if department.save
          render json: department, status: 201
        else
          render json: { errors: department.errors }, status: 422
        end
      end

      def update
        department = Department.find(params[:id])

        if department.update_attributes(department_params)
          render json: department, status: 200
        else
          render json: { errors: department.errors }, status: 422
        end
      end

      def destroy
        department = Department.find(params[:id])
        department.destroy
        head 204
      end

      private

      def department_params
        params.require(:department).permit(:description, :status)
      end
    end
  end
end
