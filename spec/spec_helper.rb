require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

RSpec.configure do |c|
  c.fixtures_path = 'spec/approvals'
end