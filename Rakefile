require 'rubygems'
require 'bundler'

Bundler.setup(:default, :development)

require 'rake'

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('../config/environment', __FILE__)
end

unless ENV['RACK_ENV'] == 'production'
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = FileList['spec/api/*_spec.rb']
  end

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)

  task default: [:rubocop, :spec]
end

# Setup ActiveRecord migrations
# cf. https://github.com/rails/rails/issues/11609
require 'yaml'
require 'active_record'
include ActiveRecord::Tasks

db_dir = File.expand_path('../db', __FILE__)

DatabaseTasks.env = ENV['RACK_ENV'] || 'development'
DatabaseTasks.database_configuration = YAML.load_file('./config/database.yml')
DatabaseTasks.db_dir = db_dir
DatabaseTasks.migrations_paths = File.join(db_dir, 'migrate')

load 'active_record/railties/databases.rake'
