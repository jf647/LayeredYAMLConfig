require 'minitest/autorun'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestErbMulti < MiniTest::Unit::TestCase
    def setup
        OurConfig.clear
        OurConfig.reset
    end
    def test_erb_multi
        OurConfig.templates = true
        c = OurConfig.instance 'test/ex11.yaml'
        assert_instance_of(OurConfig, c)
        assert_match '<%=', c[:foo][:bar][:baz]
        c.add 'test/ex12.yaml'
        assert_equal 'gzonk', c[:foo][:bar][:baz]
    end
    def test_erb_multi_recursive
        OurConfig.templates = true
        c = OurConfig.instance 'test/ex13.yaml'
        assert_instance_of(OurConfig, c)
        assert_match '<%=', c[:a][:b][:c]
        c.add 'test/ex14.yaml'
        assert_match '<%=', c[:a][:b][:c]
        c.add 'test/ex15.yaml'
        assert_equal 'j', c[:a][:b][:c]
    end
end
