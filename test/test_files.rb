require 'test/unit'
require 'pathname'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestFiles < Test::Unit::TestCase
    def setup
        OurConfig.clear
    end
    def test_files
        c = OurConfig.instance( 'test/ex1.yaml', 'test/ex3.yaml', 'test/ex4.yaml' )
        assert_instance_of(OurConfig, c)
        files = c.files
        assert_equal( 'test/ex1.yaml', files[0] )
        assert_equal( 'test/ex3.yaml', files[1] )
        assert_equal( 'test/ex4.yaml', files[2] )
    end
end
