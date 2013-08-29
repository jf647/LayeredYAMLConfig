require 'minitest/autorun'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestErb < MiniTest::Unit::TestCase
    def setup
        OurConfig.clear
        OurConfig.reset
    end
    def test_erb_disabled
        c = OurConfig.instance( 'test/ex10.yaml' )
        assert_instance_of(OurConfig, c)
        assert_match '<%=', c[:baz]
    end
    def test_erb_enabled
        OurConfig.templates = true
        c = OurConfig.instance( 'test/ex10.yaml' )
        assert_instance_of(OurConfig, c)
        assert_equal 'bar', c[:baz]
    end
end
