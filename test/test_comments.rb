require 'test/unit'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestComments < Test::Unit::TestCase
    def setup
        LayeredYAMLConfig.clear_all
    end
    def test_file_with_comments
        c = OurConfig.instance( 'test/ex5.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c)
        assert_equal('bar', c[:foo])
        assert_equal(%w(baz quux), c[:bar])
        assert_equal({ 'foo' => 'bar', 'baz' => 'quux' }, c["baz"])
    end
    def test_embedded_comments
        c = OurConfig.instance( 'test/ex6.yaml' )
        assert_instance_of(ActiveSupport::HashWithIndifferentAccess, c)
        assert_equal(%w(bar baz), c[:foo])
        assert_equal({ 'bar' => 'baz', 'quux' => 'gzonk' }, c["bar"])
    end
end
