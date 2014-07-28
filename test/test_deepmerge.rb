require 'minitest_helper'

# dummy class for inheritance
class OurConfig < LayeredYAMLConfig
end

# tests deep merging of layers
class TestDeepMerge < Minitest::Test
  def setup
    LayeredYAMLConfig.clear_all
    LayeredYAMLConfig.reset_all
  end

  def test_deep_merge
    c = OurConfig.instance('test/ex7.yaml', 'test/ex8.yaml')
    assert_instance_of(OurConfig, c)
    assert_equal('baz', c[:foo][:bar])
    assert_equal('quux', c[:foo][:gzonk])
  end
end
