require 'yaml'
require 'forwardable'
require 'hash_deep_merge'
require 'active_support/core_ext/hash/indifferent_access'

class LayeredYAMLConfig

    extend Forwardable

    private_class_method :new
    attr_reader :files
    def_delegators :@cfg, :[], :[]=, :to_hash

    # catalog of per-subclass instances
    @@instances = Hash.new
    
    # catalog of per-subclass options
    @@skipbad = Hash.new
    @@skipbad.default = false
    @@skipmissing = Hash.new
    @@skipmissing.default = true

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
    
    def self.skipbad=(newval)
        @@skipbad[self] = newval
    end

    def self.skipmissing=(newval)
        @@skipmissing[self] = newval
    end
    
    def add(*files)

        # due to the multi passing of splat args, we can get Array-in-Array situations here
        files.flatten.each do |fn|
            @files.push(fn)
            if ! File.exists?(fn)
                next if @@skipmissing[self.class]
                raise ArgumentError, "file #{fn} does not exist"
            end
            begin
                data = YAML.load(File.open(fn))
                if ! data.instance_of?(Hash)
                    raise ArgumentError, "file #{fn} does not contain a Hash"
                end
                @cfg.deep_merge!(data.symbolize_keys)
            rescue
                if ! @@skipbad[self.class]
                    raise
                end
            end
        end

    end

    def initialize(*files)

        @cfg = Hash.new.with_indifferent_access
        @files = []
        add(files)

    end

end
