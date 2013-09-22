require 'minitest_helper'
require 'minitest/autorun'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestErbArray < Minitest::Test
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
    def test_erb_array_of_array
        OurConfig.templates = true
        c = OurConfig.instance 'test/ex18.yaml'
        assert_instance_of(OurConfig, c)
        assert_equal '1', c[:c][0][0]
        assert_equal '2', c[:c][0][1]
        assert_equal '3', c[:c][0][2]
        assert_equal '1', c[:c][1][0]
        assert_equal '2', c[:c][1][1]
        assert_equal '3', c[:c][1][2]
    end
    def test_erb_array_of_hash
        OurConfig.templates = true
        c = OurConfig.instance 'test/ex18.yaml'
        assert_instance_of(OurConfig, c)
        assert_equal '1', c[:d][0][:one]
        assert_equal '2', c[:d][0][:two]
        assert_equal '3', c[:d][0][:three]
    end
end
