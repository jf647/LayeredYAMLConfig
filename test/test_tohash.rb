require 'minitest_helper'

# dummy class for inheritance
class OurConfig < LayeredYAMLConfig
end

# Tests converting to a hash
class TestToHash < Minitest::Test
  def setup
    OurConfig.clear
    OurConfig.reset
  end

  def test_tohash
    c = OurConfig.instance('test/ex1.yaml')
    assert_instance_of(OurConfig, c)
    assert_equal({ 'foo' => 'bar' }, c.to_hash)
  end
end
