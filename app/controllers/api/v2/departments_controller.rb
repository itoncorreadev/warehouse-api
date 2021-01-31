class Api::V2::DepartmentsController < ApplicationController

  def index
    departments = Department.ransack(params[:q]).result

    render json: departments, status: 200
  end

  def show
    department = Department.find(params[:id])

    render json: department, status: 200
  end
end
