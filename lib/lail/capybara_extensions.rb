require "capybara/rails"

require 'lail/capybara_extensions/session'
require 'lail/capybara_extensions/capybara'

require "selenium-webdriver"
Capybara.default_selector = :css
Capybara.default_driver = :rack_test
