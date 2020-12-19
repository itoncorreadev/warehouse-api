FROM ruby:2.5

ARG RAILS_ENV
ARG NODE_ENV
ARG RAILS_MASTER_KEY

ENV LANG=C.UTF-8 \
    TZ=America/Sao_Paulo \
    EDITOR=vim \
    RAILS_ENV=$RAILS_ENV \
    NODE_ENV=$NODE_ENV

EXPOSE 3000 3009 3035

RUN apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

RUN mkdir -p /app
WORKDIR /app
COPY . .
RUN bundle install && \
    npm cache verify && \
    yarn install
CMD bundle install && \
    npm cache verify && \
    yarn install && \
    rm -Rf /app/tmp/pids/ && bundle exec rails server -b 0.0.0.0 -p 3000
