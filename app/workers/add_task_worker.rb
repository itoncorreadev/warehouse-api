class AddTaskWorker
  require 'csv'

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(csv_file)
    sleep 8
    CSV.foreach(csv_file, headers: true) do |task|
    Task.create(title: task[0], user_id: 1)
    end
  end
end
