# Use official Ruby image
FROM ruby:3.2.2

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Copy Gemfiles
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install gems
RUN bundle install

# Copy the rest of the app
COPY . /app

# Precompile assets and migrate DB
RUN bundle exec rake assets:precompile
RUN bundle exec rake db:migrate

# Set environment variables
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Expose port 3000
EXPOSE 3000

# Start the server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
