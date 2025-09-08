FROM ruby:2.7-bullseye

# Variáveis de ambiente
ARG RAILS_ENV
ARG NODE_ENV
ENV LANG=C.UTF-8 \
    TZ=America/Sao_Paulo \
    EDITOR=vim \
    RAILS_ENV=$RAILS_ENV \
    NODE_ENV=$NODE_ENV

# Configura fuso horário e dependências do sistema
RUN apt-get update -qq && \
    apt-get install -y tzdata build-essential libpq-dev postgresql-client curl && \
    ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Node e Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# Copia entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Diretório de trabalho
RUN mkdir -p /app
WORKDIR /app

# Copia Gemfile e Gemfile.lock para instalar gems antes de copiar todo o projeto
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:1.17.3 && bundle install

# Copia restante do projeto
COPY . .

ENTRYPOINT ["entrypoint.sh"]
