require 'yaml'
require 'forwardable'
require 'hash_deep_merge'
require 'active_support/core_ext/hash/indifferent_access'

# a config class made up of multiple layers, with later ones overriding earlier ones
class LayeredYAMLConfig
  extend Forwardable

  private_class_method :new
  attr_reader :files
  def_delegators :@cfg, :[], :[]=, :to_hash

  def self.instance(*files)
    if @@instances[self].nil?
      if !files.empty?
        @@instances[self] = new(files)
      else
        fail ArgumentError, "no files in initial construction of #{self}"
      end
    else
      unless files.empty?
        fail ArgumentError, "instance for #{self} already constructed"
      end
    end
    @@instances[self]
  end

  def self.clear
    @@instances[self] = nil
  end

  def self.clear_all
    @@instances = {}
  end

  def self.reset
    %w(skipbad skipmissing templates emptyok).each do |opt|
      @@opts[opt.to_sym].delete(self)
    end
  end

  def self.reset_all
    @@opts = {
      skipbad: Hash.new(false),
      skipmissing: Hash.new(true),
      templates: Hash.new(false),
      emptyok: Hash.new(false)
    }
  end

  # create class-level option accessors
  %w(skipbad skipmissing templates emptyok).each do |opt|
    define_singleton_method(opt.to_sym) do
      @@opts[opt.to_sym][self]
    end
    define_singleton_method("#{opt}=".to_sym) do |newval|
      @@opts[opt.to_sym][self] = newval
    end
  end

  # add files to an instance
  def add(*files)
    # due to the multi passing of splat args, we can get Array-in-Array situations here
    files.flatten.each do |fn|
      @files.push(fn)
      unless File.exist?(fn)
        next if self.class.skipmissing
        fail ArgumentError, "file #{fn} does not exist"
      end
      begin
        merge_file(fn)
      rescue
        raise unless self.class.skipbad
      end
    end

    # resolve templates
    resolve_templates if self.class.templates
  end

  # constructor
  def initialize(*files)
    @cfg = {}.with_indifferent_access
    @files = []
    add(files)
  end

  # create catalog of per-subclass instances and options
  clear_all
  reset_all

  private

  def merge_file(fn)
    data = YAML.load(File.open(fn))
    unless data.instance_of?(Hash)
      fail ArgumentError, "file #{fn} does not contain a Hash"
    end
    @cfg.deep_merge!(data.deep_symbolize_keys).deep_symbolize_keys
  end
end
