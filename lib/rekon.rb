require 'yajl/json_gem'
require 'excon'
require 'ripple'

module Rekon
  extend ActiveSupport::Autoload

  autoload :App
  autoload :Data
  autoload :Server
end

require 'rekon/version'
