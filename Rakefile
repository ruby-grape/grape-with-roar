require 'rubygems'
require 'bundler'

Bundler.setup(:default, :development)

require 'rake'

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('config/environment', __dir__)
end

unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = FileList['spec/api/*_spec.rb']
  end

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)

  task default: %i[rubocop spec]
end

# Setup ActiveRecord migrations
# cf. https://github.com/rails/rails/issues/11609
require 'yaml'
require 'active_record'
include ActiveRecord::Tasks

db_dir = File.expand_path('db', __dir__)

DatabaseTasks.env = ENV['RACK_ENV'] || 'development'
yml = ERB.new(File.read(File.expand_path('config/database.yml', __dir__))).result
DatabaseTasks.database_configuration = YAML.safe_load(yml, aliases: true)[ENV.fetch('RACK_ENV', nil)]
DatabaseTasks.db_dir = db_dir
DatabaseTasks.migrations_paths = File.join(db_dir, 'migrate')

load 'active_record/railties/databases.rake'
