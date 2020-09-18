FROM ruby:2.7.1-alpine
MAINTAINER sam.snafu@gmail.com

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    postgresql-client \
    git \
    nodejs-current \
    yarn \
    tzdata \
    imagemagick

ARG USER
ARG HOME
ARG UID

RUN apk add --update \
    sudo

RUN echo "Welcome home: $USER => $UID"

RUN adduser -S -D -G users -u $UID $USER
RUN addgroup -S sudo
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/sudo 
RUN adduser $USER sudo

RUN echo "Welcome home: $USER"

ENV APP_HOME ${HOME}

WORKDIR ${HOME}

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY Gemfile* ${HOME}/

RUN gem install bundler
RUN bundle install

COPY . .

EXPOSE 3000

# Start up
#ENTRYPOINT ["sh", "./entrypoint.sh"]
