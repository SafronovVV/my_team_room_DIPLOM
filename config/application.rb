require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TeamRoom
  class Application < Rails::Application
    config.load_defaults 5.1

    config.generators do |g|
      g.template_engine :slim
    end
    config.action_view.prefix_partial_path_with_controller_namespace = false
    # config.to_prepare do
    #   Devise::SessionsController.skip_before_action :registration_completed?
    #   Devise::RegistrationsController.skip_before_action :registration_completed?
    # end
  end
end
