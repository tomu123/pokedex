source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Add support to load environment variables from `.env` files.
  gem "dotenv-rails", "~> 2.7"
  # Add Rspec as testing framework instead of Minitest
  gem "rspec", "~> 3.11"
  gem "rspec-rails", "~> 5.1"
  # Generates real-looking test data
  gem "faker", "~> 2.21"
  # Helper for writing factories for Ruby tests
  gem "factory_bot_rails", "~> 6.2"
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Add Code Linter and Formatter Rubocop which works according to Ruby Style Guide and configured by rubocop.yml
  gem "rubocop", "~> 1.29"
end

group :test do
  # Library for stubbing and setting expectations on HTTP requests in Ruby.
  gem "webmock", "~> 3.14"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Add support for Pagination
gem "pagy", "~> 5.10"

# Add support for using ActiveJob with SideKiq as queing backend
gem "sidekiq", "~> 6.4"
gem "sidekiq-failures", "~> 1.0"

# Add support for authorization and authentication using OAuth2 standard protocol
gem "doorkeeper", "~> 5.5"
gem "doorkeeper-grants_assertion", "~> 0.3.1"

# Add support for trailblazer high-level domain architecture style
gem "trailblazer-rails", "~> 2.4"
gem "reform-rails", "~> 0.2.3"

# Representable Dependency for JSON documents
gem "multi_json", "~> 1.15"

# Representable maps objects to documents (rendering) and documents to objects (parsing) using representers.
gem "representable", "~> 3.1"

# Add support for Google Cloud Storage
gem "google-cloud-storage", "~> 1.36", require: false

# Faraday is an HTTP client library that provides a common interface over many adapters (such as Net::HTTP)
# and embraces the concept of Rack middleware when processing the request/response cycle.
gem "faraday", "~> 2.3"

# Add searching(filtering and sorting) capabilities using Ransanck gem
gem "ransack", "~> 3.2"

# Add support to use SendGrid as Email Provider
gem "sendgrid-actionmailer", "~> 3.2"
