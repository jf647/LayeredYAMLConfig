require 'test/unit'
require 'layeredyamlconfig'

class OurConfig1 < LayeredYAMLConfig
end

class OurConfig2 < LayeredYAMLConfig
end

class TestClear < Test::Unit::TestCase
    def setup
        LayeredYAMLConfig.clear_all
    end
    def test_clear_oneclass
        c1 = OurConfig1.instance( 'test/ex1.yaml' )
        c2 = OurConfig2.instance( 'test/ex1.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c1)
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c2)
        assert_raises(ArgumentError) {
            OurConfig1.instance( 'test/ex1.yaml' )
        }
        OurConfig1.clear
        c3 = OurConfig1.instance( 'test/ex1.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c3)
        c4 = OurConfig2.instance
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c4)
        assert_equal(c2, c4)
    end
    def test_clear_all
        c1 = OurConfig1.instance( 'test/ex1.yaml' )
        c2 = OurConfig2.instance( 'test/ex1.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c1)
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c2)
        assert_raises(ArgumentError) {
            OurConfig1.instance( 'test/ex1.yaml' )
        }
        assert_raises(ArgumentError) {
            OurConfig2.instance( 'test/ex1.yaml' ) 
        }
        LayeredYAMLConfig.clear_all
        c3 = OurConfig1.instance( 'test/ex1.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c3)
        c4 = OurConfig2.instance( 'test/ex1.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c4)
    end
end
