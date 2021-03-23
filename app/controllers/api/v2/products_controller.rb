class Api::V2::ProductsController < Api::V2::BaseController
  before_action :authenticate_user!

  def index
    products = Product.ransack(params[:q]).result

    render json: products, status: 200
  end

  def show
    product = Product.find(params[:id])

    render json: product, status: 200
  end

  def create
    group = Group.first
    category = Category.first

    product = Product.new(product_params)

    product.category = category
    product.group = group

    if product.save
      render json: product, status: 201
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def update
    product = Product.find(params[:id])

    if product.update_attributes(product_params)
      render json: product, status: 200
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    head 204
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :code, :product_type, :measure, :min, :med, :max, :location, :status, :group_id, :category_id)
  end

end
