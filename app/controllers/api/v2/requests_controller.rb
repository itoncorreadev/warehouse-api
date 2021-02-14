class Api::V2::RequestsController < Api::V2::BaseController
  before_action :authenticate_user!

  def index
    requests = Request.ransack(params[:q]).result()

    render json: requests, status: 200
  end

  def show
    request = Request.find(params[:id])

    render json: request, status: 200
  end

  def create
    department = Department.first
    supplier = Supplier.first

    request = current_user.requests.new(request_params)

    request.department = department
    request.supplier = supplier

    if request.save
      render json: request, status: 201
    else
      render json: { errors: request.errors }, status: 422
    end
  end

  def update
    request = Request.find(params[:id])

    if request.update_attributes(request_params)
      render json: request, status: 200
    else
      render json: { errors: request.errors }, status: 422
    end
  end

  def destroy
    request = Request.find(params[:id])
    request.destroy
    head 204
  end

  private

  def request_params
    params.require(:request).permit(:date, :request_type, :description, :document_type, :document_code, :status)
  end
end
