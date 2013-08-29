Gem::Specification.new do |s|
    s.name = 'layeredyamlconfig'
    s.version = '1.4.0'
    s.date = '2013-08-29'
    s.summary = 'YAML Configs with multiple layers and ERB evaluation'
    s.description = 'Read config from multiple YAML files',
    s.add_dependency( 'psych', '>= 1.3.4' )
    s.add_dependency( 'activesupport', '>= 3.2.12' )
    s.add_dependency( 'hash-deep-merge' )
    s.add_dependency( 'erbuis' )
    s.authors = ['James FitzGibbon']
    s.email = 'james@nadt.net'
    s.files = ['lib/layeredyamlconfig.rb']
end
