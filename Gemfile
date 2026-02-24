source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', github: 'rails/rails', branch: 'main'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '= 6.2.2'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby ]

gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'devise'

group :development, :test do
  gem 'brakeman'
  gem 'rubocop', '~> 1.56', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'debug', platforms: %i[mri]
  gem 'sidekiq'
  gem 'sidekiq-cron'
end

group :development do
  gem 'error_highlight', '>= 0.4.0', platforms: [:ruby]
end

group :test do
  gem 'database_cleaner', '~> 1.3'
  gem 'factory_bot_rails', '~> 5.0'
  gem 'rspec-rails'
  gem 'jsonapi-rspec'
  gem 'simplecov', '0.17.1'
  gem 'webmock', '~> 3.7'
  gem 'timecop'
  gem 'rails-controller-testing'
  gem 'ffaker', '~> 2.9'
  gem 'rspec-sidekiq'
end

# Doorkeeper is an oAuth2 provider built in Ruby
gem 'doorkeeper'

# For Excel file reports
gem 'acts_as_list', '~> 0.8'
gem 'caxlsx'
gem 'caxlsx_rails'
gem 'acts_as_caxlsx', github: 'caxlsx/acts_as_caxlsx'
gem 'axlsx_styler', github: 'axlsx-styler-gem/axlsx_styler'

# For Date Valdiations
gem 'date_validator'

gem 'rack-cors'

gem 'acts_as_paranoid'

# For import countries and state
# gem 'carmen', '>= 1.0', '< 1.2'

# For filters to record
# gem 'ransack', '~> 2.3.0'

gem 'cancancan', '~> 3.0'

# gem 'grpc', '~> 1.59', '>= 1.59.2'
# gem 'grpc-tools', '0.14.1.pre1'
# gem 'anycable-rails'
gem 'redis', '>= 4.0'

gem "aws-sdk-s3", require: false
