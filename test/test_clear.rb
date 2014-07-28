require 'minitest_helper'

# dummy class for inheritance
class OurConfig1 < LayeredYAMLConfig
end

# dummy class for inheritance
class OurConfig2 < LayeredYAMLConfig
end

# tests clearing existing configs
class TestClear < Minitest::Test
  def setup
    LayeredYAMLConfig.clear_all
    LayeredYAMLConfig.reset_all
  end

  def test_clear_oneclass
    c1 = OurConfig1.instance('test/ex1.yaml')
    c2 = OurConfig2.instance('test/ex1.yaml')
    assert_instance_of(OurConfig1, c1)
    assert_instance_of(OurConfig2, c2)
    assert_raises(ArgumentError) do
      OurConfig1.instance('test/ex1.yaml')
    end
    OurConfig1.clear
    c3 = OurConfig1.instance('test/ex1.yaml')
    assert_instance_of(OurConfig1, c3)
    c4 = OurConfig2.instance
    assert_instance_of(OurConfig2, c4)
    assert_equal(c2, c4)
  end

  def test_clear_all
    c1 = OurConfig1.instance('test/ex1.yaml')
    c2 = OurConfig2.instance('test/ex1.yaml')
    assert_instance_of(OurConfig1, c1)
    assert_instance_of(OurConfig2, c2)
    assert_raises(ArgumentError) do
      OurConfig1.instance('test/ex1.yaml')
    end
    assert_raises(ArgumentError) do
      OurConfig2.instance('test/ex1.yaml')
    end
    LayeredYAMLConfig.clear_all
    c3 = OurConfig1.instance('test/ex1.yaml')
    assert_instance_of(OurConfig1, c3)
    c4 = OurConfig2.instance('test/ex1.yaml')
    assert_instance_of(OurConfig2, c4)
  end
end
