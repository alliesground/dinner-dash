FROM ruby:2.7.1-alpine
MAINTAINER sam.snafu@gmail.com

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    postgresql-client \
    git \
    nodejs-current \
    yarn \
    tzdata

ENV APP_HOME /workdir
RUN mkdir ${APP_HOME}
WORKDIR ${APP_HOME}

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY Gemfile* ${APP_HOME}/

RUN gem install bundler
RUN bundle install

COPY . .

EXPOSE 8080

# Start up
#ENTRYPOINT ["sh", "./entrypoint.sh"]
