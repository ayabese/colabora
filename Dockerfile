FROM ruby:3.1.2-slim

ARG UID
ARG GID
ARG PROJECT_FOLDER

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    sudo \
    npm \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR "/usr/local/bin"
RUN gem update --system && gem install bundler
RUN npm install -g yarn

COPY . $PROJECT_FOLDER
WORKDIR $PROJECT_FOLDER

ENTRYPOINT ["./docker/entrypoint.sh"]
EXPOSE 3000
