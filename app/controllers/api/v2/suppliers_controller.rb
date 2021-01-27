class Api::V2::SuppliersController < Api::V2::BaseController
  before_action :authenticate_user!

  def index
    suppliers = Supplier.ransack(params[:q]).result

    render json: suppliers, status: 200
  end

  def show
    supplier = Supplier.find(params[:id])

    render json: supplier, status: 200
  end

  def create
    supplier = Supplier.new(supplier_params)

    if supplier.save
      render json: supplier, status: 201
    else
      render json: { errors: supplier.errors }, status: 422
    end
  end

  def update
    supplier = Supplier.find(params[:id])

    if supplier.update_attributes(supplier_params)
      render json: supplier, status: 200
    else
      render json: { errors: supplier.errors }, status: 422
    end
  end

  def destroy
    supplier = Supplier.find(params[:id])
    supplier.destroy
    head 204
  end

  private

  def supplier_params
    params.require(:supplier).permit(:description, :type_document, :document, :address, :phone, :comment)
  end
end
