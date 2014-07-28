require 'minitest_helper'

# dummy class for inheritance
class OurConfig < LayeredYAMLConfig
end

# tests config files with comments
class TestComments < Minitest::Test
  def setup
    LayeredYAMLConfig.clear_all
    LayeredYAMLConfig.reset_all
  end

  def test_file_with_comments
    c = OurConfig.instance('test/ex5.yaml')
    assert_instance_of(OurConfig, c)
    assert_equal('bar', c[:foo])
    assert_equal(%w(baz quux), c[:bar])
    assert_equal({ 'foo' => 'bar', 'baz' => 'quux' }, c['baz'])
  end

  def test_embedded_comments
    c = OurConfig.instance('test/ex6.yaml')
    assert_instance_of(OurConfig, c)
    assert_equal(%w(bar baz), c[:foo])
    assert_equal({ 'bar' => 'baz', 'quux' => 'gzonk' }, c['bar'])
  end
end
