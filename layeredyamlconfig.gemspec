Gem::Specification.new do |s|
    s.name = 'layeredyamlconfig'
    s.version = '1.3.0'
    s.date = '2013-04-04'
    s.summary = 'YAML Configs with multiple layers'
    s.description = 'Read config from multiple YAML files',
    s.add_dependency( 'psych', '>= 1.3.4' )
    s.add_dependency( 'activesupport', '>= 3.2.12' )
    s.add_dependency( 'hash-deep-merge' )
    s.authors = ['James FitzGibbon']
    s.email = 'james@nadt.net'
    s.files = ['lib/layeredyamlconfig.rb']
end
