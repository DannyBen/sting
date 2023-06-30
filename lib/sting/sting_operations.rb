require 'extended_yaml'

class Sting
  module StingOperations
    def initialize(source = nil)
      self << source if source
    end

    def <<(source)
      if source.is_a? Hash
        content = source.transform_keys(&:to_s)

      elsif source.include? '*'
        Dir[source.to_s].each { |file| push file }

      elsif File.directory? source
        Dir["#{source}/*.yml"].each { |file| push file }

      else
        source = "#{source}.yml" unless /\.ya?ml$/.match?(source)
        content = ExtendedYAML.load source
      end

      settings.merge! content if content
    end
    alias push <<

    def [](*keys)
      settings.dig(*keys.map(&:to_s))
    end

    def method_missing(name, *args, &_block)
      name = name.to_s
      return settings[name] if has_key? name

      suffix = nil

      if name.end_with?('=', '!', '?')
        suffix = name[-1]
        name = name[0..-2]
      end

      case suffix
      when '='
        settings[name] = args.first

      when '?'
        !!settings[name]

      when '!'
        raise ArgumentError, "Key '#{name}' does not exist" unless has_key? name

        settings[name]

      end
    end

    def settings
      @settings ||= {}
    end
    alias to_h settings

    def reset!
      @settings = nil
    end

    def has_key?(key)
      settings.has_key? key.to_s
    end
  end
end
