module DTK
  class Converge
    require File.expand_path('converge/puppet_apply',File.dirname(__FILE__))
    InvocationsBaseDir = File.expand_path('../invocations',File.dirname(__FILE__))

    def self.create(type,hash_options={})
      case type
        when :puppet_apply then PuppetApply.new(hash_options)
      else
        raise DTK::Error.new("Illegal type #{type}")
      end
    end

    def self.invocations_base_dir()
      InvocationsBaseDir
    end

    private
    attr_reader :config
    def initialize(hash_options={})
      @config = hash_options
    end
  end
end

