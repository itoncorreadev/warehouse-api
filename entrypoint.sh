#!/bin/bash
set -e

# Espera o banco
until pg_isready -h database -p 5432 -U postgres; do
  echo "Waiting for database..."
  sleep 2
done

# Roda migrations só em dev (evita bagunçar no test)
if [ "$RAILS_ENV" = "development" ]; then
  bundle exec rails db:migrate
fi

# Se passar argumento, roda ele. Se não, roda rails s
exec "$@"
