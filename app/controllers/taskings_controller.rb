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
      AddTaskWorker.perform_async(csv_file)
      redirect_to api_v2_tasks_path
    end

    def destroy
      RemoveTaskWorker.perform_async
      redirect_to api_v2_tasks_path
    end

    private

    def set_tasking
      @task = Task.all
    end
end
