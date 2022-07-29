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
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN addgroup --system --gid $GID  user
RUN adduser --system --shell /bin/bash --disabled-password --gecos '' --uid $UID --gid $GID user
RUN adduser user sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER user

RUN sudo gem update --system && gem install bundler

WORKDIR $PROJECT_FOLDER

ENTRYPOINT ["./docker/entrypoint.sh"]

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
