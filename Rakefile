require 'rake/testtask'
require 'hoe'

Hoe.spec 'layeredyamlconfig' do
    developer("James FitzGibbon", "james@nadt.net")
    license "MIT"
end

task :default => [:unit_tests]

desc "Run basic tests"
Rake::TestTask.new("unit_tests") { |t|
    t.libs.push 'lib'
    t.libs.push 'test'
    t.pattern = 'test/test_*.rb'
    t.verbose = true
    t.warning = true
}
