source 'https://rubygems.org'

gem 'activerecord', require: 'active_record'
gem 'activerecord-jdbcpostgresql-adapter', platforms: :jruby
gem 'bigdecimal'
gem 'grape', ENV.fetch('GRAPE_VERSION', '>= 0')
gem 'grape-roar'
gem 'grape-swagger'
# grape-roar 0.5 passes representer options to Hash#to_json, rejected by JSON 3.
gem 'json', '< 3'
gem 'kaminari-grape'
gem 'nokogiri'
gem 'pg', platforms: :mri
gem 'puma'
gem 'rack', ENV.fetch('RACK_VERSION', '>= 0')
gem 'rack-cors'
gem 'rackup', require: false

group :development, :test do
  gem 'rake'
end

group :development do
  gem 'rubocop'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end

group :test do
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'faraday-rack'
  gem 'hyperclient'
  gem 'rack-test'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
end
