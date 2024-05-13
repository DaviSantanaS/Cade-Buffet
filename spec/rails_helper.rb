require 'capybara/rspec'
require 'selenium-webdriver'

require 'simplecov'
SimpleCov.start 'rails' if ENV['RAILS_ENV'] == 'test'

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# Require support files
Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Configure Capybara to use Selenium with Chrome in headless mode
  Capybara.register_driver :selenium_chrome_headless do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('headless')  # Running without a visible window
    options.add_argument('disable-gpu')  # Disabling GPU hardware acceleration
    options.add_argument('no-sandbox')  # Bypass OS security model
    options.add_argument('window-size=1400,900')  # Default window size
    options.add_argument('disable-dev-shm-usage')  # Overcome limited resource problems

    service = Selenium::WebDriver::Service.chrome(path: '/usr/local/bin/chromedriver')
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options, service: service)
  end

  # Set the JavaScript driver to selenium_chrome_headless
  Capybara.javascript_driver = :selenium_chrome_headless

  # Set the default driver to rack_test for non-JavaScript tests
  Capybara.default_driver = :rack_test

  # Setup Capybara for system tests
  config.before(type: :system) do
    driven_by :rack_test
  end

  config.before(type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end

  # Configure RSpec
  config.fixture_paths = [Rails.root.join('spec/fixtures')]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
