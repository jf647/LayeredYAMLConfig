LayeredYAMLConfig
=================

Overview
--------

Ruby configuration library that layered multiple YAML files on top of each other

Synopsis
--------

```ruby
class MyConfig < LayeredYAMLConfig
end

MyConfig.skipbad = true
cfg = MyConfig.instance( 'ex7.yaml', 'ex8.yaml', 'ex9.yaml', 'ex10.yaml' )
puts cfg[:foo]['bar']
puts cfg['foo'][:gzonk]
```

ex7.yaml:
```yaml
---
foo:
    bar: baz
```

ex8.yaml:
```yaml
---
foo:
    gzonk: quux
```

ex10.yaml:
```text
This is not a YAML file
```

To use LayeredYAMLConfig, create a new class that inherits from it.  The new class is a singleton
that can only be constructed the first time #instance is called.  Pass one or more YAML filenames which
will be read and deep merged on top of each other in left-to-right order.

Files that are missing are skipped by default.  Files that are bad (i.e. do not parse as valid YAML) cause
an exception to be thrown.  This behaviour can be overridden with #skipbad= and #skipmissing= before
calling #instance the first time.

The hash which is returned is a ActiveSupport::HashWithIndifferentAccess, so you can get at the keys as
strings or symbols as you prefer

Contributing to LayeredYAMLConfig
---------------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the version or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.
