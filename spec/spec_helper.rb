require 'rubygems'
require 'simplecov'
require 'simplecov-lcov'

SimpleCov::Formatter::LcovFormatter.config do |config|
  config.report_with_single_file = true
  config.single_report_path = 'coverage/lcov.info'
end

SimpleCov.start do
  enable_coverage :branch
  add_filter '/spec/'
  add_filter '/vendor/'
  track_files '{api,app}/**/*.rb'
  formatter SimpleCov::Formatter::MultiFormatter.new(
    [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::LcovFormatter]
  )
end

ENV['RACK_ENV'] ||= 'test'

require 'rack/test'

require File.expand_path('../config/environment', __dir__)

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec

  config.before(:suite) do
    ActiveRecord::Migration.maintain_test_schema!
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do |_example|
    DatabaseCleaner.start
  end

  config.after do |_example|
    DatabaseCleaner.clean
  end
end
