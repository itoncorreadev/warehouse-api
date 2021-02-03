class Api::V2::RequestsController < Api::V2::BaseController
  #before_action :authenticate_user!

  def index
    requests = Request.ransack(params[:q]).result()
    requests = requests.where(product_id: params[:product_id])
    #requests = Request.find_by_product_id(params[:product_id])

    render json: requests, status: 200
  end

  private

  def request_params
    params.require(:request).permit(:date, :request_type, :document, :document_code, :quantity, :unit_price, :total_price, :observation, :status)
  end
end
