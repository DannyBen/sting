Sting - Minimal Settings Library
==================================================

[![Gem Version](https://badge.fury.io/rb/sting.svg)](https://badge.fury.io/rb/sting)
[![Build Status](https://travis-ci.com/DannyBen/sting.svg?branch=master)](https://travis-ci.com/DannyBen/sting)
[![Maintainability](https://api.codeclimate.com/v1/badges/c8afe395a8f2cf290fec/maintainability)](https://codeclimate.com/github/DannyBen/sting/maintainability)

---

Sting is a minimal, lightweight, multi-YAML settings library.

---

Installation
--------------------------------------------------

```shell
$ gem install sting
```


Features
--------------------------------------------------

- [Aggressively minimalistic][1].
- Settings are accessible through a globally available class.
- Can be used either as a singleton class or as an instance.
- Load and merge one or more YAML files or hashes.
- Settings objects are standard ruby hashes, arrays and basic types.
- Ability to update settings at runtime.
- [Ability to extend](#extending-yaml-files) (import) other YAML files.
- ERB code in the YAML files will be evaluated.


Nonfeatures
--------------------------------------------------

- No dot notation access to nested values - Use `Settings.server['host']` 
  instead of `Settings.server.host`.
- No special generators for Rails. 
  [Usage with rails is still trivial](#using-with-rails).


Usage
--------------------------------------------------

### Using as a singleton class

```ruby
require 'sting'

# If you want to use a different name than Sting (optional)
Settings = Sting

# Load some YAML files. If the provided filename does not end with '.yml' or 
# '.yaml', we will add '.yml' to it.
Settings << 'one'
Settings << 'two.yml'

# Adding additional files can also be done with `#push`. These two are the 
# same.
Settings << 'one'
Settings.push 'one'

# Merge with another options hash
Settings << { port: 3000, host: 'localhost' }

# Access values
p Settings.host
p Settings['host']
p Settings[:host]

# Access nested values
p Settings.server['host']

# Access nested values safely (get nil if any of the keys does not exist)
p Settings[:server, :host]
p Settings[:server, :production, :host]

# Get the hash of all values
p Settings.settings

# Check if a key is defined
p Settings.has_key? :hello

# Access value, but raise an exception if it does not exist
p Settings.host!

# Access boolean values, or check if a key exists
p Settings.host?

# Update a value (in memory only, not in file)
Settings.port = 3000

# Reset (erase) all values
Settings.reset!
```

### Using as an instance

All the above operations are also available to instances of `Sting`.

```ruby
require 'sting'

# Create an instance.
config = Sting.new

# Or, create an instance, and provide the first source file to it.
config = Sting.new 'settings'

# Load additional YAML files. 
config << 'local_settings'
```


### Extending YAML files

Sting uses [ExtendedYAML], which means you can use the `extends` key to load
one ormore YAML files into your loaded configuration files:

```yaml
# Extend a single file (extension is optional)
extends: some-other-file.yml

# Extend multiple files
extends:
- some-file
- another-file
```


Using with Rails
--------------------------------------------------

You can use this however you wish in Rails. This is the recommended 
implementation:

Add sting to your Gemfile:

```ruby
gem 'sting'
```

Create an initializer:

```ruby
# config/initializers/settings.rb
Settings = Sting
Settings << "#{Rails.root}/config/settings"
Settings << "#{Rails.root}/config/settings/#{Rails.env}"
```

Create four config files:

- config/**settings**.yml
- config/settings/**development**.yml
- config/settings/**production**.yml
- config/settings/**test**.yml


[1]: https://github.com/DannyBen/sting/blob/master/lib/sting/sting_operations.rb
[2]: https://github.com/DannyBen/extended_yaml
