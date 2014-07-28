require 'minitest_helper'

# dummy class for inheritance
class OurConfig < LayeredYAMLConfig
end

# Tests multiple values in ERB templates
class TestErbMulti < Minitest::Test
  def setup
    OurConfig.clear
    OurConfig.reset
  end

  def test_erb_multi
    OurConfig.templates = true
    assert_raises(RuntimeError) do
      OurConfig.instance 'test/ex11.yaml'
    end
    c = OurConfig.instance 'test/ex11.yaml', 'test/ex12.yaml'
    assert_instance_of(OurConfig, c)
    assert_equal 'gzonk', c[:foo][:bar][:baz]
  end

  def test_erb_multi_recursive
    OurConfig.templates = true
    assert_raises(RuntimeError) do
      OurConfig.instance 'test/ex13.yaml'
    end
    assert_raises(RuntimeError) do
      OurConfig.instance 'test/ex13.yaml', 'test/ex14.yaml'
    end
    c = OurConfig.instance 'test/ex13.yaml', 'test/ex14.yaml', 'test/ex15.yaml'
    assert_instance_of(OurConfig, c)
    assert_equal 'j', c[:a][:b][:c]
  end
end
