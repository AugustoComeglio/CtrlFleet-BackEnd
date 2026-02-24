# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

require 'webmock/rspec'

def get_values_in_hash(h)
  @result ||= []

  h.values.each do |value|
    if value.class == Hash
      get_values_in_hash(value)
    else
      @result += [value]
    end
  end

  @result
end

FactoryBot.define do
  sequence(:random_string) { FFaker::Lorem.sentence }
  sequence(:random_description) { FFaker::Lorem.paragraphs(Kernel.rand(1..5)).join("\n") }
  sequence(:random_email) { FFaker::Internet.email }
  sequence(:random_float) { BigDecimal("#{rand(200)}.#{rand(99)}") }
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

require 'ffaker'

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include FactoryBot::Syntax::Methods
end