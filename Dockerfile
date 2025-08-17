# Use official Ruby image
FROM ruby:3.2.2

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Copy all files
COPY . /app

# Install gems
RUN bundle install

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
