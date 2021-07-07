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
      build-essential nodejs curl
# Ensure that our apt package list is updated and install a few
# packages to ensure that we can compile assets (nodejs).

WORKDIR ${ARG_APP_PATH}

COPY Gemfile ${ARG_APP_PATH}
COPY Gemfile.lock ${ARG_APP_PATH}
# Add app files into docker image

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
# Add bundle entry point to handle bundle cache

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
# Bundle installs with binstubs to our custom /bundle/bin volume path. Let system use those stubs.

RUN gem update --system ${ARG_RUBYGEMS_VERSION}

RUN gem install bundler:${ARG_BUNDLER_VERSION}

RUN curl -SL https://github.com/ufoscout/docker-compose-wait/releases/download/${ARG_COMPOSE_WAIT_VER}/wait -o /wait
RUN chmod +x /wait