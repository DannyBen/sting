lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sting/version'

Gem::Specification.new do |s|
  s.name        = 'sting'
  s.version     = Sting::VERSION
  s.summary     = 'Minimal, lightweight, multi-YAML settings'
  s.description = 'Minimal, lightweight, multi-YAML settings'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/dannyben/sting'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.6.0'

  s.add_runtime_dependency 'extended_yaml', '~> 0.2'
  s.metadata['rubygems_mfa_required'] = 'true'
end
