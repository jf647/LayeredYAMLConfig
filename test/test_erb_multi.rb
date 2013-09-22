require 'minitest_helper'
require 'minitest/autorun'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestErbMulti < Minitest::Test
    def setup
        OurConfig.clear
        OurConfig.reset
    end
    def test_erb_multi
        OurConfig.templates = true
        assert_raises(RuntimeError) {
            OurConfig.instance 'test/ex11.yaml'
        }
        c = OurConfig.instance 'test/ex11.yaml', 'test/ex12.yaml'
        assert_instance_of(OurConfig, c)
        assert_equal 'gzonk', c[:foo][:bar][:baz]
    end
    def test_erb_multi_recursive
        OurConfig.templates = true
        assert_raises(RuntimeError) {
            OurConfig.instance 'test/ex13.yaml'
        }
        assert_raises(RuntimeError) {
            OurConfig.instance 'test/ex13.yaml', 'test/ex14.yaml'
        }
        c = OurConfig.instance 'test/ex13.yaml', 'test/ex14.yaml', 'test/ex15.yaml'
        assert_instance_of(OurConfig, c)
        assert_equal 'j', c[:a][:b][:c]
    end
end
