require 'yaml'
require 'erb'

class Sting
  class << self
    def <<(path)
      path = "#{path}.yml" unless path =~ /\.ya?ml$/
      content = File.read path
      content = YAML.load(ERB.new(content).result)
      settings.merge! content if content
    end

    def [](key)
      settings[key.to_s]
    end

    def method_missing(name, *args, &blk)
      name = name.to_s
      return settings[name] if has_key? name

      suffix = nil

      if name.end_with? *['=', '!', '?']
        suffix = name[-1]
        name = name[0..-2]
      end

      case suffix
      when "="
        settings[name] = args.first

      when "?"
        !!settings[name]

      when "!"
        if has_key? name
          return settings[name]
        else
          raise ArgumentError, "Key '#{name}' does not exist"
        end

      else
        nil

      end

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
