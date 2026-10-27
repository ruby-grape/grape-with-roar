ENV['RACK_ENV'] ||= 'test'

require File.expand_path('application', __dir__)

yml = ERB.new(File.read(File.expand_path('database.yml', __dir__))).result
ActiveRecord::Base.configurations = YAML.safe_load(yml, aliases: true)
ActiveRecord::Base.establish_connection(ENV.fetch('RACK_ENV').to_sym)
