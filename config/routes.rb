# frozen_string_literal: true

require 'api_version_constraint'
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Sidekiq::Web => '/sidekiq'

  get 'taskings/data', to: 'taskings#data'
  post 'taskings/upload', to: 'taskings#upload'
  post 'taskings/destroy', to: 'taskings#destroy'

  devise_for :users, only: [:sessions], controllers: { sessions: 'api/v1/sessions' }

  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1) do
      resources :users, only: %i[index show create update destroy]
      resources :sessions, only: %i[create destroy]
      resources :tasks, only: %i[index show create update destroy]
    end

    namespace :v2, path: '/', constraints: ApiVersionConstraint.new(version: 2, default: true) do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users, only: %i[index show create update destroy]
      resources :sessions, only: %i[create destroy]
      resources :tasks, only: %i[index show create update destroy]
      resources :suppliers, only: %i[index show create update destroy]
      resources :groups, only: %i[index show create update destroy]
      resources :departments, only: %i[index show create update destroy]
      resources :categories, only: %i[index show create update destroy]
      resources :products, only: %i[index show create update destroy]
      resources :requests do
        resources :details, only: %i[index show create update destroy]
      end
    end
  end
end
