require 'rubygems'
require 'bundler'

Bundler.setup(:default, :development)

require 'rake'

ENV['RACK_ENV'] ||= 'development'

task :environment do
  require File.expand_path('../config/environment', __FILE__)
end

if ENV['RACK_ENV'] == 'development'
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = FileList['spec/api/*_spec.rb']
  end

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)

  task default: [:rubocop, :spec]
end
