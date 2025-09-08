# frozen_string_literal: true

namespace :dev do
  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    puts 'Resetando o banco de dados...'
    `rake db:drop db:create db:migrate db:seed`
    `rake db:test:prepare`
    puts 'banco de dados resetado...'
  end
end
