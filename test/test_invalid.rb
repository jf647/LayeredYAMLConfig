require 'minitest_helper'

# dummy class for inheritance
class OurConfig < LayeredYAMLConfig
end

# tests invalid YAML
class TestInvalidYaml < Minitest::Test
  def setup
    OurConfig.clear
    OurConfig.reset
  end

  def test_badyaml
    assert_raises(ArgumentError) do
      OurConfig.instance('test/exbad1.yaml')
    end
  end

  def test_nothashyaml
    assert_raises(ArgumentError) do
      OurConfig.instance('test/exbad2.yaml')
    end
  end

  def test_missingfile
    cfg = OurConfig.instance('test/nonexistent.yaml')
    assert_instance_of(OurConfig, cfg)
  end

  def test_missingfile_off
    OurConfig.skipmissing = false
    assert_raises(ArgumentError) do
      OurConfig.instance('test/nonexistent.yaml')
    end
  end

  def test_skipbad_on
    OurConfig.skipbad = true
    cfg = OurConfig.instance('test/exbad2.yaml')
    assert_instance_of(OurConfig, cfg)
  end
end
