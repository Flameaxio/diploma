FROM node:14 AS node_base

RUN echo "NODE Version:" && node --version
RUN echo "NPM Version:" && npm --version

FROM ruby:2.5.1

RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 14.18.1
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV APP_HOME /diploma

# Clear cache
RUN apt-get clean && apt-get autoclean

# Get essentials
RUN apt-get update -qq && apt-get install --no-install-recommends -y build-essential libpq-dev
RUN npm install -g yarn

# Clear cache again
RUN apt-get clean && apt-get autoclean

# Initialize workspace
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
ADD package.json yarn.lock $APP_HOME/
RUN yarn install
RUN bundle install
COPY . $APP_HOME
RUN RAILS_ENV=production bundle exec rake assets:precompile
CMD ["rails","server","-b","0.0.0.0"]
