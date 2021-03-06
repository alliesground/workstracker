require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Workstracker
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators do |g|
      g.test_framework :rspec
      g.orm :active_record
      g.template_engine :haml
      g.helper_specs false
      g.view_specs false
      g.routing_specs false
      g.controller_specs false
      g.request_specs false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
      g.factory_girl false
      g.stylesheets = false
      g.helper = false
      g.javascripts = false
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:3000', 'workstracker.s3-website-ap-southeast-2.amazonaws.com'
        resource '*',
          #headers: %w(Authorization),
          headers: :any,
          methods: :any,
          expose: ['Authorization', 'access-token', 'expiry', 'token-type', 'uid', 'client'],
          max_age: 600
      end
    end
  end
end
