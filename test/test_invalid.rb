require 'minitest_helper'
require 'minitest/autorun'
require 'layeredyamlconfig'

class OurConfig < LayeredYAMLConfig
end

class TestInvalidYaml < Minitest::Test
    def setup
        OurConfig.clear
        OurConfig.reset
    end
    def test_badyaml
        assert_raises(ArgumentError) {
            OurConfig.instance( 'test/exbad1.yaml' )
        }
    end
    def test_nothashyaml
        assert_raises(ArgumentError) {
            OurConfig.instance( 'test/exbad2.yaml' )
        }
    end
    def test_missingfile
        cfg = OurConfig.instance( 'test/nonexistent.yaml' )
        assert_instance_of(OurConfig, cfg)
    end
    def test_missingfile_off
        OurConfig.skipmissing = false
        assert_raises(ArgumentError) {
            OurConfig.instance( 'test/nonexistent.yaml' )
        }
    end
    def test_skipbad_on
        OurConfig.skipbad = true
        cfg = OurConfig.instance( 'test/exbad2.yaml' )
        assert_instance_of(OurConfig, cfg)
    end
end
