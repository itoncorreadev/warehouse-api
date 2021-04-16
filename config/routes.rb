require 'api_version_constraint'
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  get 'taskings/data', to: 'taskings#data'
  post 'taskings/upload', to: 'taskings#upload'
  post 'taskings/destroy', to: 'taskings#destroy'

  devise_for :users, only: [:sessions], controllers: { sessions: 'api/v1/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # constraints: { subdomain: 'api' }
  namespace :api, defaults: { format: :json }, path: '/' do
    namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1) do
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
    end

    namespace :v2, path: '/', constraints: ApiVersionConstraint.new(version: 2, default: true) do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users, only: [:index, :show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
      resources :suppliers, only: [:index, :show, :create, :update, :destroy]
      resources :groups, only: [:index, :show, :create, :update, :destroy]
      resources :departments, only: [:index, :show, :create, :update, :destroy]
      resources :categories, only: [:index, :show, :create, :update, :destroy]
      resources :products, only: [:index, :show, :create, :update, :destroy]
      resources :requests do
        resources :details, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end
end
