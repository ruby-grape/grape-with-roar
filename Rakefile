require 'rubygems'
require 'bundler'

Bundler.setup(:default, :development)

require 'rake'

ENV['RACK_ENV'] ||= 'development'

if ENV['RACK_ENV'] == 'test'
  require 'rspec/core'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |spec|
    spec.pattern = FileList['spec/api/*_spec.rb']
  end
end

task :environment do
  require File.expand_path('../config/environment', __FILE__)
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: [:rubocop, :spec]
