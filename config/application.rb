require_relative "boot"

require "rails/all"
require_relative "../lib/request_timer"

Bundler.require(*Rails.groups)

module SupportHub
  class Application < Rails::Application
    config.load_defaults 7.2

    config.time_zone = "UTC"
    config.x.support_email = "support@supporthub.example"

    config.middleware.use RequestTimer
  end
end