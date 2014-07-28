require 'minitest_helper'

# dummy class for inheritance
class OurConfig < LayeredYAMLConfig
end

# Tests ERB templates
class TestErb < Minitest::Test
  def setup
    OurConfig.clear
    OurConfig.reset
  end

  def test_erb_disabled
    c = OurConfig.instance('test/ex10.yaml')
    assert_instance_of(OurConfig, c)
    assert_match '<%=', c[:baz]
  end

  def test_erb_enabled
    OurConfig.templates = true
    c = OurConfig.instance('test/ex10.yaml')
    assert_instance_of(OurConfig, c)
    assert_equal 'bar', c[:baz]
  end
end
