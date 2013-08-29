require 'minitest/autorun'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestErbEmpty < MiniTest::Unit::TestCase
    def setup
        OurConfig.clear
        OurConfig.reset
    end
    def test_erb_empty
        OurConfig.templates = true
        assert_raises(RuntimeError) {
            OurConfig.instance 'test/ex17.yaml'
        }
        OurConfig.emptyok = true
        c = OurConfig.instance 'test/ex17.yaml'
        assert_instance_of(OurConfig, c)
        assert_empty c[:a][:b][:e]
    end
end
