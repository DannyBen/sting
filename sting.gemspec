lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'sting/version'

Gem::Specification.new do |s|
  s.name        = 'sting'
  s.version     = Sting::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Minimal, lightweight, multi-YAML settings"
  s.description = "Minimal, lightweight, multi-YAML settings"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/dannyben/sting'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.2.0"

  s.add_development_dependency 'byebug', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rspec_fixtures', '~> 0.3'
  s.add_development_dependency 'runfile', '~> 0.10'
  s.add_development_dependency 'runfile-tasks', '~> 0.4'
  s.add_development_dependency 'simplecov', '~> 0.15'
end
