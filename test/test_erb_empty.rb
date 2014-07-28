require 'minitest_helper'

# dummy class for inheritance
class OurConfig < LayeredYAMLConfig
end

# Tests empty values in ERB templates
class TestErbEmpty < Minitest::Test
  def setup
    OurConfig.clear
    OurConfig.reset
  end

  def test_erb_empty
    OurConfig.templates = true
    assert_raises(RuntimeError) do
      OurConfig.instance 'test/ex17.yaml'
    end
    OurConfig.emptyok = true
    c = OurConfig.instance 'test/ex17.yaml'
    assert_instance_of(OurConfig, c)
    assert_empty c[:a][:b][:e]
  end
end
