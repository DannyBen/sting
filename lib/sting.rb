require 'yaml'
require 'erb'
require 'sting/sting_operations'

class Sting
  include StingOperations

  class << self
    include StingOperations
  end
end
