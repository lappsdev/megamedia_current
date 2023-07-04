FROM ruby:3.2.2
RUN set -x \
    && curl -sL 'https://deb.nodesource.com/setup_16.x' | bash - \
    && apt-get -y install nodejs \
    && ln -s /usr/bin/nodejs /usr/local/bin/node

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    # Install git
    git \
    tzdata \
    libpq-dev \
    libldap2-dev \
    libaio1 \
    libaio-dev \
    smbclient \ 
    ffmpeg \
    # Install tools
    openssl \
    nano \
    rlwrap \
    make \
    unzip \
    zip \
    tar \
    locales \
    cron \
    ca-certificates
RUN mkdir /varejo4tech
WORKDIR /varejo4tech
RUN node -v
RUN yarn install
COPY Gemfile /varejo4tech/Gemfile
COPY Gemfile.lock /varejo4tech/Gemfile.lock
RUN bundle install --without development test

COPY package.json /varejo4tech/package.json

COPY . /varejo4tech
ENV RAILS_ENV='production'
ENV RACK_ENV='production' 

EXPOSE 5000

CMD service cron start && bundle exec rake db:migrate && rails assets:precompile && rails webpacker:compile && rails s -b  0.0.0.0 

