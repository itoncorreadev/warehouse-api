class Api::V2::ProductsController < Api::V2::BaseController
  before_action :authenticate_user!

  def index
    products = Product.ransack(params[:q]).result

    render json: products, status: 200
  end
end
