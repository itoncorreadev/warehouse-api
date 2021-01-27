class Api::V2::GroupsController < Api::V2::BaseController
  before_action :authenticate_user!

  def index
    group = Group.ransack(params[:q]).result

    render json: group, status: 200
  end

  def show
    group = Group.find(params[:id])

    render json: group, status: 200
  end
end
