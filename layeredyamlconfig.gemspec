# -*- encoding: utf-8 -*-
# stub: layeredyamlconfig 1.4.4.20140728081247 ruby lib

Gem::Specification.new do |s|
  s.name = "layeredyamlconfig"
  s.version = "1.4.4.20140728081247"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["James FitzGibbon"]
  s.date = "2014-07-28"
  s.description = "LayeredYAMLConfig provides a simple config file that supports multiple\nlayers.  Values in the right or uppermost layers override values in lower\nlayers.  This makes it easy to share configuration without duplication while\nstill allowing what needs to be different to vary.\n\nFor example:\n\n    program.default.conf\n    program.server_foo.conf\n    program.site_bar.conf\n    program.conf\n\nOptionally, leaf nodes can be evaluated using as ERB templates, feeding the\nconfiguration into itself."
  s.email = ["james@nadt.net"]
  s.extra_rdoc_files = ["History.txt", "LICENSE.txt", "Manifest.txt", "README.txt"]
  s.files = [".gemtest", "Gemfile", "History.txt", "LICENSE.txt", "Manifest.txt", "README.txt", "Rakefile", "layeredyamlconfig.gemspec", "lib/layeredyamlconfig.rb", "lib/layeredyamlconfig/array_traverse.rb", "lib/layeredyamlconfig/core.rb", "lib/layeredyamlconfig/hash_traverse.rb", "lib/layeredyamlconfig/templates.rb", "lib/layeredyamlconfig/version.rb", "test/ex1.yaml", "test/ex10.yaml", "test/ex11.yaml", "test/ex12.yaml", "test/ex13.yaml", "test/ex14.yaml", "test/ex15.yaml", "test/ex16.yaml", "test/ex17.yaml", "test/ex18.yaml", "test/ex2.yaml", "test/ex3.yaml", "test/ex4.yaml", "test/ex5.yaml", "test/ex6.yaml", "test/ex7.yaml", "test/ex8.yaml", "test/ex9.yaml", "test/exbad1.yaml", "test/exbad2.yaml", "test/minitest_helper.rb", "test/test_addlayer.rb", "test/test_clear.rb", "test/test_comments.rb", "test/test_constructor.rb", "test/test_deepmerge.rb", "test/test_erb.rb", "test/test_erb_array.rb", "test/test_erb_empty.rb", "test/test_erb_hash.rb", "test/test_erb_multi.rb", "test/test_files.rb", "test/test_invalid.rb", "test/test_multi.rb", "test/test_tohash.rb"]
  s.homepage = "https://github.com/jf647/LayeredYAMLConfig"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--title", "TestLayeredyamlconfig Documentation", "--quiet"]
  s.rubyforge_project = "layeredyamlconfig"
  s.rubygems_version = "2.2.2"
  s.summary = "LayeredYAMLConfig provides a simple config file that supports multiple layers"
  s.test_files = ["test/test_erb_hash.rb", "test/test_invalid.rb", "test/test_constructor.rb", "test/test_erb_multi.rb", "test/test_addlayer.rb", "test/test_comments.rb", "test/test_tohash.rb", "test/test_multi.rb", "test/test_erb_empty.rb", "test/test_erb_array.rb", "test/test_clear.rb", "test/test_erb.rb", "test/test_deepmerge.rb", "test/test_files.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport-core-ext>, ["~> 4.0.0.2"])
      s.add_runtime_dependency(%q<hash-deep-merge>, ["~> 0.1.1"])
      s.add_runtime_dependency(%q<erubis>, ["~> 2.7.0"])
      s.add_development_dependency(%q<hoe-yard>, [">= 0.1.2"])
      s.add_development_dependency(%q<hoe>, ["~> 3.7.1"])
      s.add_development_dependency(%q<hoe-gemspec>, ["~> 1.0.0"])
      s.add_development_dependency(%q<hoe-bundler>, ["~> 1.2.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.7.1"])
      s.add_development_dependency(%q<simplecov-rcov>, ["~> 0.2.3"])
      s.add_development_dependency(%q<minitest>, ["~> 5.0.8"])
      s.add_development_dependency(%q<minitest-reporters>, ["~> 1.0.4"])
      s.add_development_dependency(%q<rubocop>, ["~> 0.24.1"])
      s.add_development_dependency(%q<flog>, ["~> 4.3.0"])
    else
      s.add_dependency(%q<activesupport-core-ext>, ["~> 4.0.0.2"])
      s.add_dependency(%q<hash-deep-merge>, ["~> 0.1.1"])
      s.add_dependency(%q<erubis>, ["~> 2.7.0"])
      s.add_dependency(%q<hoe-yard>, [">= 0.1.2"])
      s.add_dependency(%q<hoe>, ["~> 3.7.1"])
      s.add_dependency(%q<hoe-gemspec>, ["~> 1.0.0"])
      s.add_dependency(%q<hoe-bundler>, ["~> 1.2.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.7.1"])
      s.add_dependency(%q<simplecov-rcov>, ["~> 0.2.3"])
      s.add_dependency(%q<minitest>, ["~> 5.0.8"])
      s.add_dependency(%q<minitest-reporters>, ["~> 1.0.4"])
      s.add_dependency(%q<rubocop>, ["~> 0.24.1"])
      s.add_dependency(%q<flog>, ["~> 4.3.0"])
    end
  else
    s.add_dependency(%q<activesupport-core-ext>, ["~> 4.0.0.2"])
    s.add_dependency(%q<hash-deep-merge>, ["~> 0.1.1"])
    s.add_dependency(%q<erubis>, ["~> 2.7.0"])
    s.add_dependency(%q<hoe-yard>, [">= 0.1.2"])
    s.add_dependency(%q<hoe>, ["~> 3.7.1"])
    s.add_dependency(%q<hoe-gemspec>, ["~> 1.0.0"])
    s.add_dependency(%q<hoe-bundler>, ["~> 1.2.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.7.1"])
    s.add_dependency(%q<simplecov-rcov>, ["~> 0.2.3"])
    s.add_dependency(%q<minitest>, ["~> 5.0.8"])
    s.add_dependency(%q<minitest-reporters>, ["~> 1.0.4"])
    s.add_dependency(%q<rubocop>, ["~> 0.24.1"])
    s.add_dependency(%q<flog>, ["~> 4.3.0"])
  end
end
