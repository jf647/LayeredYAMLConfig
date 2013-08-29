require 'yaml'
require 'forwardable'
require 'hash_deep_merge'
require 'active_support/core_ext/hash/indifferent_access'

class LayeredYAMLConfig

    extend Forwardable

    private_class_method :new
    attr_reader :files
    def_delegators :@cfg, :[], :[]=, :to_hash
    
    def self.instance(*files)
        if @@instances[self].nil?
            if ! files.empty?
                @@instances[self] = new(files)
            else
                raise ArgumentError, "no files in initial construction of #{self}"
            end
        else
            if ! files.empty?
                raise ArgumentError, "instance for #{self} already constructed"
            end
        end
        return @@instances[self]
    end

    def self.clear
        @@instances[self] = nil
    end

    def self.clear_all
        @@instances = Hash.new
    end

    def self.reset
        %w(skipbad skipmissing templates emptyok).each do |opt|
            @@opts[opt.to_sym].delete(self)
        end
    end

    def self.reset_all
        @@opts = {
            :skipbad => Hash.new(false),
            :skipmissing => Hash.new(true),
            :templates => Hash.new(false),
            :emptyok => Hash.new(false),
        }
    end
    
    # create class-level option accessors
    %w(skipbad skipmissing templates emptyok).each do |opt|
        self.define_singleton_method(opt.to_sym) do
            @@opts[opt.to_sym][self]
        end
        self.define_singleton_method("#{opt}=".to_sym) do |newval|
            @@opts[opt.to_sym][self] = !!newval
        end
    end

    # add files to an instance
    def add(*files)
        # due to the multi passing of splat args, we can get Array-in-Array situations here
        files.flatten.each do |fn|
            @files.push(fn)
            if ! File.exists?(fn)
                next if self.class.skipmissing
                raise ArgumentError, "file #{fn} does not exist"
            end
            begin
                data = YAML.load(File.open(fn))
                if ! data.instance_of?(Hash)
                    raise ArgumentError, "file #{fn} does not contain a Hash"
                end
                @cfg.deep_merge!(data.deep_symbolize_keys).deep_symbolize_keys
            rescue
                if ! self.class.skipbad
                    raise
                end
            end
        end

        # resolve templates
        if self.class.templates
            resolve_templates
        end
    end

    # constructor
    def initialize(*files)
        @cfg = Hash.new.with_indifferent_access
        @files = []
        add(files)
    end
    
    # create catalog of per-subclass instances and options
    self.clear_all
    self.reset_all

end
