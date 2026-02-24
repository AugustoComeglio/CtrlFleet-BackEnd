require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CtrlfleetBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.time_zone = 'Buenos Aires'
    config.generators.test_framework :rspec
    # config.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
    config.i18n.default_locale = :es
    config.api_only = true

    # Add owner models to doorkeeper
    config.autoload_paths << "#{Rails.root}/lib/doorkeeper"
    config.after_initialize do
      require 'ctrlfleet_token_response'
    end

    config.hosts.clear

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.encoding = "utf-8"

    # The Active Job adapter must be set to :sidekiq or else
    # it will use the default value provided by Rails, which is :async
    config.active_job.queue_adapter = :sidekiq

    # config.action_mailer.deliver_later_queue_name = :default
    # config.action_mailbox.queues.routing    = nil
    # config.active_storage.queues.analysis   = nil
    # config.active_storage.queues.purge      = nil
    # config.active_storage.queues.mirror     = nil
  end
end
