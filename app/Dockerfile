FROM ruby:slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends cron

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock timekeeper ./
COPY lib lib

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1 \
  && bundle install

# Run cron in the foreground to prevent app from exiting
CMD ["cron", "-f"]
