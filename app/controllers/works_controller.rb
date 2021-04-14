class WorksController < ApplicationController
    def create
        MyJob.perform_later record 
    end
end