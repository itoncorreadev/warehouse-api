class Api::V2::TasksController < Api::V2::BaseController
  #before_action :authenticate_user!

  def index
    tasks = Task.ransack(params[:q]).result

    render json: tasks, status: 200
  end

  def show
    task = Task.find(params[:id])

    render json: task, status: 200
  end

  def create
    task = current_user.tasks.build(task_params)

    if task.save
      render json: task, status: 201
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def update
    user = User.find(task_params[:user_id])
    task = Task.find(params[:id])

    if task.update_attributes(task_params)
      render json: task, status: 200
    else
      render json: { errors: task.errors }, status: 422
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    head 204
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :done, :user_id)
  end
end
