require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eatfast
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Default Rails setup does NOT allow subdirectories in assets/images
     config.assets.paths << Rails.root.join('app', 'assets', 'images', 'devise', '**')

    # Rails 7 defaults to libvips as the variant processor
    # libvips is up to 10x faster and consumes 1/10th the memory of imagemagick
    # If you need to use imagemagick, uncomment this to switch
    # config.active_storage.variant_processor = :mini_magick
    config.active_storage.variant_processor = :vips
  end
end
