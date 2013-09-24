require 'rake/testtask'
require 'hoe'

Hoe.plugin :gemspec
Hoe.plugin :bundler

Hoe.spec 'layeredyamlconfig' do
    developer("James FitzGibbon", "james@nadt.net")
    license "MIT"
    dependency 'psych', '~> 2.0.1'
    dependency 'activesupport-core-ext', '~> 4.0.0.2'
    dependency 'hash-deep-merge', '~> 0.1.1'
    dependency 'erubis', '~> 2.7.0'
    dependency 'hoe', '~> 3.7.1', :dev
    dependency 'hoe-gemspec', '~> 1.0.0', :dev
    dependency 'hoe-bundler', '~> 1.2.0', :dev
    dependency 'simplecov', '~> 0.7.1', :dev
    dependency 'simplecov-console', '~> 0.1.1', :dev
    dependency 'minitest', '~> 5.0.8', :dev
    dependency 'minitest-debugger', '~> 1.0.2', :dev
end

task :default => [ 'unit_tests' ]

task :package => [ 'gem:spec', 'bundler:gemfile' ]

desc "Run basic tests"
Rake::TestTask.new("unit_tests") do |t|
    t.libs.push 'lib'
    t.libs.push 'test'
    t.pattern = 'test/test_*.rb'
    t.verbose = true
    t.warning = true
end
