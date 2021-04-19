namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do

    puts "Resetando o banco de dados..."
    %x(rake db:drop db:create db:migrate db:seed db:test:prepare)
    puts "banco de dados resetado..."

  end
end
