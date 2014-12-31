ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../application', __FILE__)

ActiveRecord::Base.default_timezone = :utc

db_config = YAML.load_file('config/database.yml')[ENV['RACK_ENV']]
ActiveRecord::Base.establish_connection(db_config)
