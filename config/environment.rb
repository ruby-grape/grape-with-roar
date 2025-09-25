ENV['RACK_ENV'] ||= 'test'

require File.expand_path('application', __dir__)

db_config = YAML.load_file('config/database.yml')[ENV.fetch('RACK_ENV', nil)]
ActiveRecord::Base.establish_connection(db_config)
