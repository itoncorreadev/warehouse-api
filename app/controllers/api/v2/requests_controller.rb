class Api::V2::RequestsController < Api::V2::BaseController
  before_action :authenticate_user!

  def index
    requests = Request.ransack(params[:q]).result

    render json: requests, status: 200
  end
end
