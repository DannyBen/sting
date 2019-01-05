require 'yaml'
require 'erb'

class Sting
  module StingOperations
    def initialize(source = nil)
      self << source if source
    end

    def <<(source)
      if source.is_a? Hash
        content = source.collect{ |k,v| [k.to_s, v] }.to_h
      else
        source = "#{source}.yml" unless source =~ /\.ya?ml$/
        content = File.read source
        content = YAML.load(ERB.new(content).result)
      end
      settings.merge! content if content
    end
    alias_method :push, :<<

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
