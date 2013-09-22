require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console,
]
SimpleCov.start do
    add_filter '/vendor/'
    add_filter '/test/'
end

require 'minitest/debugger' if ENV['DEBUG']
