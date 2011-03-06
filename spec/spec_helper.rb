$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems' # Use the gems path only for the spec suite
require 'rekon'
require 'rspec'

Dir[File.join(File.dirname(__FILE__), "support", "*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
end

