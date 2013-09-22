require 'minitest_helper'
require 'minitest/autorun'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestAddLayer < Minitest::Test
    def setup
        LayeredYAMLConfig.clear_all
        LayeredYAMLConfig.reset_all
    end
    def test_add_layer
        c = OurConfig.instance( 'test/ex7.yaml', 'test/ex8.yaml' )
        assert_instance_of(OurConfig, c)
        assert_equal('baz', c[:foo][:bar])
        assert_equal('quux', c[:foo][:gzonk])
        c.add( 'test/ex9.yaml' )
        assert_instance_of(OurConfig, c)
        assert_equal('wobble', c[:foo]['wibble'])
    end
end
