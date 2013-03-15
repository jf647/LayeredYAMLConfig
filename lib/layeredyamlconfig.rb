require 'yaml'
require 'hash_deep_merge'
require 'active_support/core_ext/hash/indifferent_access'

class LayeredYAMLConfig

    @@instances = Hash.new
    @@skipbad = Hash.new
    @@skipbad.default = false
    @@skipmissing = Hash.new
    @@skipmissing.default = true

    private_class_method :new
    attr_reader :cfg

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
        return @@instances[self].cfg

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

    def initialize(*files)

        @cfg = Hash.new.with_indifferent_access

        # attempt to load each file using YAML
        files.flatten.each do |fn|
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

end
