class TaskingsController < ApplicationController
    before_action :set_tasking, only: [:index, :data]

    def index
      if @task.length > 0
        redirect_to taskings_data_path
      else
        upload
      end
    end
  
    def data
    end
  
    def upload
      csv_file = File.join(Rails.root,'db','task.csv')
      AddTaskWorker.set(queue: :tasks).perform_async(csv_file)
      redirect_to api_v2_tasks_path
    end
  
    def destroy
      RemoveTaskWorker.set(queue: :tasks).perform_async
      redirect_to api_v2_tasks_path
    end
  
    private
  
    def set_tasking
      @task = Task.all
    end
end