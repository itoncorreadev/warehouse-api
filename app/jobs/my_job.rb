class MyJob < ApplicationJob
  queue_as :my_jobs

  def perform(record)
    record.do_work
  end
end
