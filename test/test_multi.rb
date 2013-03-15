require 'test/unit'
require 'layeredyamlconfig'

class OurConfig1 < LayeredYAMLConfig
end

class OurConfig2 < LayeredYAMLConfig
end

class TestMulti < Test::Unit::TestCase
    def setup
        LayeredYAMLConfig.clear_all
    end
    def test_construct_two_from_same_file
        c1 = OurConfig1.instance( 'test/ex1.yaml' )
        c2 = OurConfig2.instance( 'test/ex1.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c1)
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c2)
        assert_equal('bar', c1[:foo])
        assert_equal('bar', c1['foo'])
        assert_equal('bar', c2[:foo])
        assert_equal('bar', c2['foo'])
    end
    def test_construct_two_from_diff_files
        c1 = OurConfig1.instance( 'test/ex1.yaml' )
        c2 = OurConfig2.instance( 'test/ex2.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c1)
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c2)
        assert_equal('bar', c1[:foo])
        assert_equal('bar', c1['foo'])
        assert_equal('baz', c2[:bar])
        assert_equal('baz', c2['bar'])
        refute_equal(c1, c2)
    end
    def test_reconstruct
        c1 = OurConfig1.instance( 'test/ex1.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c1)
        assert_raises(ArgumentError) {
            OurConfig1.instance( 'test/ex2.yaml' )
        }
    end
    def test_override
        c1 = OurConfig1.instance( 'test/ex3.yaml', 'test/ex4.yaml' )
        c2 = OurConfig2.instance( 'test/ex4.yaml', 'test/ex3.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c1)
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c2)
        assert_equal('baz', c1[:foo])
        assert_equal('bar', c2[:foo])
    end
    def test_deep_override
    end
end
