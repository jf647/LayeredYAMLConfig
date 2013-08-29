require 'minitest/autorun'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestConstructor < MiniTest::Unit::TestCase
    def setup
        OurConfig.clear
        OurConfig.reset
    end
    def test_nofiles
        assert_raises(ArgumentError) {
             OurConfig.instance
        }
    end
    def test_onefile
        c = OurConfig.instance( 'test/ex1.yaml' )
        assert_instance_of(OurConfig, c)
        assert_equal('bar', c[:foo])
        assert_equal('bar', c['foo'])
    end
    def test_onefile_noarray
        c = OurConfig.instance( 'test/ex1.yaml' )
        assert_instance_of(OurConfig, c)
        assert_equal('bar', c[:foo])
        assert_equal('bar', c['foo'])
    end
    def test_twofiles
        c = OurConfig.instance( 'test/ex1.yaml', 'test/ex2.yaml' )
        assert_instance_of(OurConfig, c)
        assert_equal('bar', c[:foo])
        assert_equal('bar', c['foo'])
        assert_equal('baz', c[:bar])
        assert_equal('baz', c['bar'])
    end
    def test_twofiles_3_4
        c = OurConfig.instance( 'test/ex3.yaml', 'test/ex4.yaml' )
        assert_instance_of(OurConfig, c)
        assert_equal('baz', c[:foo])
        assert_equal('baz', c['foo'])
    end
    def test_twofiles_4_3
        c = OurConfig.instance( 'test/ex4.yaml', 'test/ex3.yaml' )
        assert_instance_of(OurConfig, c)
        assert_equal('bar', c[:foo])
        assert_equal('bar', c['foo'])
    end
end
