# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include Authenticable
    end
  end
end
