Sting - Minimal Settings Library
==================================================

[![Gem Version](https://badge.fury.io/rb/sting.svg)](https://badge.fury.io/rb/sting)
[![Build Status](https://travis-ci.com/DannyBen/sting.svg?branch=master)](https://travis-ci.com/DannyBen/sting)
[![Maintainability](https://api.codeclimate.com/v1/badges/c8afe395a8f2cf290fec/maintainability)](https://codeclimate.com/github/DannyBen/sting/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c8afe395a8f2cf290fec/test_coverage)](https://codeclimate.com/github/DannyBen/sting/test_coverage)

---

Sting is a minimal, lightweight, multi-YAML settings library.

---

Installation
--------------------------------------------------

    $ gem install sting



Usage
--------------------------------------------------

```ruby
require 'sting'

# If you want to use a different name than Sting
Settings = Sting

# Load some YAML files
Settings << 'one'
Settings << 'two'

# Access values
p Settings.hello
p Settings['hello']
p Settings[:hello]

# Access all values
p Settings.all

# Check if a key is defined
p Settings.has_key? :hello
```
