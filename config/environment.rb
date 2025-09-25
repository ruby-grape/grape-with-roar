ENV['RACK_ENV'] ||= 'test'

require File.expand_path('application', __dir__)

yml = ERB.new(File.read(File.expand_path('database.yml', __dir__))).result
db_config = YAML.safe_load(yml, aliases: true)[ENV.fetch('RACK_ENV', nil)]
ActiveRecord::Base.establish_connection(db_config)
