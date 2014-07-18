$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

require 'roar/representer'
require 'roar/representer/json'
require 'roar/representer/json/hal'

Dir[File.expand_path('../../api/**/*.rb', __FILE__)].each do |f|
  require f
end

require 'active_model'
Dir[File.expand_path('../../app/models/*.rb', __FILE__)].each do |f|
  require f
end

require 'root_endpoint'
require 'acme_app'
