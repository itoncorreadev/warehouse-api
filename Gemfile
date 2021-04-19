source 'https://rubygems.org'

ruby '2.5.9'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.10.0'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise'
# ActiveModelSerializers is undergoing some renovations.
gem 'active_model_serializers', '~> 0.10.0'
# Ransack enables the creation of both simple and advanced search forms for your Ruby on Rails application
gem 'ransack'
# OmniAuth is a library that standardizes multi-provider authentication for web applications.
gem 'omniauth'
# Simple, multi-client and secure token-based authentication for Rails.
gem 'devise_token_auth'
# Centralization of locale data collection for Ruby on Rails.
gem 'rails-i18n', '~> 5.1'
# redis-rails provides a full set of stores (Cache, Session, HTTP Cache) for Ruby on Rails. See the main redis-store readme for general guidelines.
#gem 'redis-rails'
# Redis
gem 'redis'
# his gem adds a Redis::Namespace class which can be used to namespace Redis keys.
#gem 'redis-namespace'
# Sidekiq
gem 'sidekiq', '~> 6.1.3'
# A high-performance RabbitMQ background processing framework for Ruby.
# gem 'sneakers'
# Bunny is a RabbitMQ client that focuses on ease of use. It is feature complete, supports all recent RabbitMQ features and does not have any heavyweight dependencies.
# gem 'bunny'
#Manager Procfile
gem 'foreman'

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # rspec-rails brings the RSpec testing framework to Ruby on Rails as a drop-in alternative to its default testing framework, Minitest.
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem 'database_cleaner', '~> 1.5.3'
  #gem 'factory_girl_rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  # Use postgresql as the database for Active Record
  gem 'pg'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
