# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
FROM ruby:3.3.3

# Rails app lives here
WORKDIR /api

RUN apt-get update && \
    apt-get install -y build-essential default-libmysqlclient-dev

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY docker-entrypoint /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]