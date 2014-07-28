require 'minitest_helper'

# dummy class for inheritance
class OurConfig < LayeredYAMLConfig
end

# tests Hash values in ERB templates
class TestErbHash < Minitest::Test
  def setup
    OurConfig.clear
    OurConfig.reset
  end

  def test_erb_hash_of_hash
    OurConfig.templates = true
    c = OurConfig.instance 'test/ex18.yaml'
    assert_instance_of(OurConfig, c)
    assert_equal '1', c[:b][:one][:a]
    assert_equal '2', c[:b][:two][:b]
    assert_equal '3', c[:b][:three][:c]
  end
end
