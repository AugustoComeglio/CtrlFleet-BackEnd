FROM ruby:3.2.2-alpine3.18

# RUN apk --update add build-base tzdata postgresql-dev postgresql-client git

RUN apk add --no-cache --update build-base linux-headers postgresql-dev postgresql-client tzdata git libc6-compat

# RUN ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

# Pre-install grpc-related gems to build extensions without hacking Bundler
# or using BUNDLE_FORCE_RUBY_PLATFORM during bundle install
# NOTE: Use gems versions from your Gemfile.lock
# RUN gem install --platform ruby google-protobuf -v '3.25.0' -N
# RUN gem install --platform ruby grpc -v '1.59.2' -N --ignore-dependencies && \
#     rm -rf /usr/local/bundle/gems/grpc-1.59.2/src/ruby/ext


ENV APP_DIR /ctrlfleet-backend

WORKDIR $APP_DIR

COPY Gemfile ./
COPY Gemfile.lock ./

ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

RUN gem install bundler

RUN bundle config set force_ruby_platform true
RUN bundle config set --local path 'vendor/bundle'

# RUN gem install grpc
# RUN gem install grpc-tools

RUN bundle install

COPY . ./

# COPY ./bin/docker-entrypoint-dev /usr/bin/docker-entrypoint-dev
# RUN chmod +x /usr/bin/docker-entrypoint-dev

# RUN bundle install
# RUN bin/rails server

EXPOSE 3700

CMD bundle exec rails s -b '0.0.0.0'
