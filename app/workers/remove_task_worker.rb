class RemoveTaskWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
  
    def perform
      sleep 8
      Task.destroy_all
    end
end