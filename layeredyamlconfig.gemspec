$:.push File.expand_path("../lib", __FILE__)
require 'layeredyamlconfig'

Gem::Specification.new do |s|
    s.name          = 'layeredyamlconfig'
    s.version       = ThreadedLogger::VERSION
    s.summary       = 'YAML Configs with multiple layers and ERB evaluation'
    s.add_dependency( 'psych', '>= 1.3.4' )
    s.add_dependency( 'activesupport', '>= 3.2.12' )
    s.add_dependency( 'hash-deep-merge' )
    s.add_dependency( 'erubis' )
    s.authors       = ['James FitzGibbon']
    s.email         = ['james@nadt.net']
    s.files         = `git ls-files`.split("\n")
    s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
    s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f)
end
