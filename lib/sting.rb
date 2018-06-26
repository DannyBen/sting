require 'yaml'
require 'erb'

class Sting
  class << self
    def <<(path)
      path = "#{path}.yml" unless path =~ /\.ya?ml$/
      content = File.read path
      content = YAML.load(ERB.new(content).result).to_hash
      settings.merge! content
    end

    def [](key)
      settings[key.to_s]
    end

    def method_missing(method, *_)
      settings[method.to_s]
    end

    def settings
      @settings ||= {}
    end

    def reset!
      @settings = nil
    end

    def has_key?(key)
      settings.has_key? key.to_s
    end
  end
end
