# syntax=docker/dockerfile:experimental

FROM debian:stable-slim

ENV ASDF_DIR="/root/.asdf"
ENV PATH="${PATH}:/root/.asdf/shims:/root/.asdf/bin:/root/.asdf/installs/ruby/2.5.1/bin:/root/.asdf/installs/nodejs/v12.22.12/bin:root/.asdf/installs/ruby/2.5.1/lib/ruby/gems/2.5.0/gems/"
ENV DEBIAN_FRONTEND=noninteractive
ENV APP_HOME=/diploma
ENV RAILS_SERVE_STATIC_FILES='true'
ENV RAILS_ENV=production

RUN apt-get update && \
    apt-get -y install git netcat curl gpg autoconf make gcc g++ unzip libssl-dev locales bzip2 libreadline-dev zlib1g-dev build-essential libpq-dev default-libmysqlclient-dev

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf
RUN echo ". /root/.asdf/asdf.sh" >> /root/.bashrc

COPY .tool-versions /root/.tool-versions
RUN asdf plugin add ruby
RUN asdf plugin add nodejs
RUN asdf install

RUN npm i -g yarn

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock

RUN gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"

ADD package.json yarn.lock $APP_HOME/
RUN yarn install
RUN bundle install
COPY . $APP_HOME
RUN --mount=type=secret,id=RAILS_MASTER_KEY export RAILS_MASTER_KEY=$(cat /run/secrets/RAILS_MASTER_KEY) && rails assets:precompile

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]