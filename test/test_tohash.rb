require 'test/unit'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestToHash < Test::Unit::TestCase
    def setup
        OurConfig.clear
    end
    def test_tohash
        c = OurConfig.instance( 'test/ex1.yaml' )
        assert_instance_of(OurConfig, c)
        assert_equal( { 'foo' => 'bar' }, c.to_hash )
    end
end
