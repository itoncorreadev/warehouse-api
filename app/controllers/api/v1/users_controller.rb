# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      before_action :authenticate_with_token!, only: %i[update destroy]
      respond_to :json

      def index
        users = User.ransack(params[:q]).result

        render json: users, status: 200
      end

      def show
        @user = User.find(params[:id])
        respond_with @user
      rescue StandardError
        head 404
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: 201
        else
          render json: { errors: user.errors }, status: 422
        end
      end

      def update
        user = current_user

        if user.update(user_params)
          render json: user, status: 200
        else
          render json: { errors: user.errors }, status: 422
        end
      end

      def destroy
        current_user.destroy
        head 204
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :user_token)
      end
    end
  end
end
