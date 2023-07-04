FROM ruby:3.2.2

ENV NODE_VERSION=16.20.1
RUN apt install -y curl
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.0/install.sh | bash
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

RUN npm install -g yarn
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

