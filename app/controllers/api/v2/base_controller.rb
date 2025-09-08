# frozen_string_literal: true

module Api
  module V2
    class BaseController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
    end
  end
end
