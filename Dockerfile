FROM ruby:3.2.2-alpine3.18

RUN apk --update add build-base tzdata postgresql-dev postgresql-client git

ENV APP_DIR /ctrlfleet-backend

WORKDIR $APP_DIR

COPY Gemfile ./
COPY Gemfile.lock ./

ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

RUN gem install bundler

RUN bundle config set force_ruby_platform true
RUN bundle config set --local path 'vendor/bundle'
RUN bundle install

COPY . ./

# COPY ./bin/docker-entrypoint-dev /usr/bin/docker-entrypoint-dev
# RUN chmod +x /usr/bin/docker-entrypoint-dev

# RUN bundle install
# RUN bin/rails server

EXPOSE 3700

CMD bundle exec rails s -b '0.0.0.0'
