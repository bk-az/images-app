FROM ruby:2.7.2-slim

# ----------------------------------------------------------------------------------------------------
# INSTALLING REQUIRED PACKAGES
# ----------------------------------------------------------------------------------------------------

# dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential curl nodejs yarn default-libmysqlclient-dev

# mysql
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server default-libmysqlclient-dev

RUN mkdir /myapp
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock from app root directory into the /myapp/ folder in the docker container
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Run bundle install to install gems inside the gemfile
RUN bundle install
