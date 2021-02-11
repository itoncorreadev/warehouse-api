class Api::V2::GroupsController < Api::V2::BaseController
  before_action :authenticate_user!

  def index
    groups = Group.ransack(params[:q]).result

    render json: groups, status: 200
  end

  def show
    group = Group.find(params[:id])

    render json: group, status: 200
  end

  def create
    group = Group.new(group_params)

    if group.save
      render json: group, status: 201
    else
      render json: { errors: group.errors }, status: 422
    end
  end

  def update
    group = Group.find(params[:id])

    if group.update_attributes(group_params)
      render json: group, status: 200
    else
      render json: { errors: group.errors }, status: 422
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    head 204
  end

  private

  def group_params
    params.require(:group).permit(:name, :status)
  end
end
