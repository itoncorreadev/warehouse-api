class Api::V2::DepartmentsController < ApplicationController

  def index
    departments = Department.ransack(params[:q]).result

    render json: departments, status: 200
  end
end
