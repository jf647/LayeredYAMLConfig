require 'rake/testtask'
require 'rubocop/rake_task'
require 'hoe'

Hoe.plugin :gemspec
Hoe.plugin :bundler
Hoe.plugin :yard
Hoe.plugins.delete :flog

Hoe.spec 'layeredyamlconfig' do
  developer('James FitzGibbon', 'james@nadt.net')
  license 'MIT'
  dependency 'psych', '~> 2.0.1'
  dependency 'activesupport-core-ext', '~> 4.0.0.2'
  dependency 'hash-deep-merge', '~> 0.1.1'
  dependency 'erubis', '~> 2.7.0'
  dependency 'hoe', '~> 3.7.1', :dev
  dependency 'hoe-gemspec', '~> 1.0.0', :dev
  dependency 'hoe-bundler', '~> 1.2.0', :dev
  dependency 'hoe-yard', '~> 0.1.2', :dev
  dependency 'simplecov', '~> 0.7.1', :dev
  dependency 'simplecov-rcov', '~> 0.2.3', :dev
  dependency 'minitest', '~> 5.0.8', :dev
  dependency 'minitest-reporters', '~> 1.0.4', :dev
  dependency 'rubocop', '~> 0.24.1', :dev
  dependency 'flog', '~> 4.3.0', :dev
end

task default: [:unit_tests]
task package: ['gem:spec', 'bundler:gemfile']

desc 'Generate coverage report'
task coverage: [:coverage_env, :test]

task :coverage_env do
  ENV['COVERAGE'] = 'true'
end

Rake::TestTask.new('test') do |t|
  t.libs.push 'lib'
  t.libs.push 'test'
  t.pattern = 'test/test_*.rb'
  t.verbose = true
  t.warning = false
end

RuboCop::RakeTask.new(:style) do |task|
  task.patterns = ['Rakefile', 'lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = true if ENV['CI_BUILD']
end

require 'flog_task'
FlogTask.new('flog', 200, %w(lib)) do |task|
  task.verbose = true
end
