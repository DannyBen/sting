Sting - Minimal Settings Library
==================================================

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
