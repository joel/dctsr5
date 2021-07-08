ARG ARG_RUBY_VERSION=2.7.3

FROM ruby:${ARG_RUBY_VERSION}

# https://rubygems.org/gems/bundler
ARG ARG_BUNDLER_VERSION=2.2.22
# https://rubygems.org/gems/rubygems-update
ARG ARG_RUBYGEMS_VERSION=3.2.22
# https://github.com/ufoscout/docker-compose-wait/releases/
ARG ARG_COMPOSE_WAIT_VER=2.9.0
ARG ARG_APP_PATH=/app

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs
WORKDIR ${ARG_APP_PATH}

COPY . .

RUN gem update --system ${ARG_RUBYGEMS_VERSION}

RUN gem install bundler:${ARG_BUNDLER_VERSION}

RUN bin/bundle install