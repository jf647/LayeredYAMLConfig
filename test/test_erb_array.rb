require 'minitest/autorun'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestErbArray < MiniTest::Unit::TestCase
    def setup
        OurConfig.clear
        OurConfig.reset
    end
    def test_erb_array
        OurConfig.templates = true
        c = OurConfig.instance 'test/ex16.yaml'
        assert_instance_of(OurConfig, c)
        assert_equal 'd', c[:g][0]
        assert_equal 'e', c[:g][1]
        assert_equal 'f', c[:g][2]
    end
end
