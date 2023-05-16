FROM pawurb/ruby-jemalloc-node-yarn:latest

COPY Gemfile* /tmp/
COPY package.json /tmp/
COPY yarn.lock /tmp/
WORKDIR /tmp
RUN gem install bundler
RUN bundle install --jobs 5 --retry 5 --without development test
RUN yarn install

RUN mkdir /app
WORKDIR /app
COPY . /app
ENV RAILS_ENV production
ENV RACK_ENV production
RUN mkdir tmp
RUN mkdir tmp/pids
RUN apt-get update 
RUN apt-get install -y  smbclient ffmpeg

CMD ["bin/run-dev.sh"]
