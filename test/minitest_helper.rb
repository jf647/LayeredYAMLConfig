if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start do
    add_filter 'vendor'
    add_filter 'test'
  end
end

require 'minitest/autorun'
require 'minitest/unit'
if ENV['CI_BUILD']
  require 'minitest/reporters'
  Minitest::Reporters.use! Minitest::Reporters::JUnitReporter.new
end

require 'layeredyamlconfig'

# base testing class that clears all singletons after testing
class ThreadedLoggerTest < Minitest::Test
  def teardown
    ThreadedLogger.clear_all(true)
  end
end
