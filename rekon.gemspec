# -*- encoding: utf-8 -*-
require File.expand_path("../lib/rekon/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rekon"
  s.version     = Rekon::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Adam Hunter']
  s.email       = ['adamhunter@me.com']
  s.homepage    = "http://rubygems.org/gems/rekon"
  s.summary     = "TODO: Write a gem summary"
  s.description = "TODO: Write a gem description"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "rekon"
  
  # s.add_dependency "ripple",        "~> 0.9.0.beta"
  s.add_dependency "excon",         "~> 0.4.0"
  s.add_dependency "sinatra",       "~> 1.1.2"
  s.add_dependency "haml",          "~> 3.0.25"
  s.add_dependency "will_paginate", "~> 2.3.15"
  s.add_dependency "yajl-ruby",     "~> 0.7.9"
  s.add_dependency "coderay",       "~> 0.9.7"

  s.add_development_dependency "bundler",   ">= 1.0.0"
  s.add_development_dependency "rspec",     ">= 2.5.0"
  s.add_development_dependency "rack-test", ">= 0.5.7"
  # s.add_development_dependency "shotgun", ">= 0.8.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
