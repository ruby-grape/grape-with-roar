$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

require 'roar/representer'
require 'roar/json'
require 'roar/json/hal'

Mongoid.load!(File.expand_path('../config/mongoid.yml', __dir__), ENV['RACK_ENV'])

['api/extensions', 'api/presenters', 'api', 'app/models'].each do |path|
  Dir[File.expand_path("../../#{path}/*.rb", __FILE__)].each do |f|
    require f
  end
end

require 'root_endpoint'
require 'acme_app'
