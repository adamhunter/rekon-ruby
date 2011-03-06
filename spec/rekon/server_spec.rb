require 'spec_helper'
require 'rekon/server'
require 'rack/test'

#set :environment, :test

describe Rekon::Server do
  include Rack::Test::Methods

  def app
    Rekon::Server
  end
  
end
