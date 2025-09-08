# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.7.8'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers', '~> 0.10.0'
gem 'devise'
gem 'devise_token_auth'
gem 'foreman'
gem 'omniauth'
gem 'puma', '~> 3.10.0'
gem 'rack-cors'
gem 'rails', '~> 5.0.1'
gem 'rails-i18n', '~> 5.1'
gem 'ransack'
gem 'redis'
gem 'sidekiq', '~> 6.1.3'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'rswag-api'
  gem 'rswag-ui'
  gem 'rswag-specs'
end

group :test do
  gem 'database_cleaner', '~> 1.5.3'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'pg'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
