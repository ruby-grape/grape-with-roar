require 'rubygems'

ENV['RACK_ENV'] ||= 'test'

require 'rack/test'

require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec

  config.before :suite do
    Mongoid::Tasks::Database.create_indexes
    Mongo::Logger.logger.level = Logger::INFO
  end

  config.after :suite do
    Mongoid.purge!
  end

  config.around :each do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
