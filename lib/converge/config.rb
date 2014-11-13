require 'singleton'
class DTK::Converge
  class Config < Hash
    include Singleton
    def initialize(hash={})
      super()
      set_defaults()
    end
    def self.[](k)
      instance[k.to_sym]
    end
    def self.[]=(k,v)
      instance[k.to_sym] = v
    end
    def self.set_from_hash(hash)
      hash.each_pair{|k,v|instance[k.to_sym]=v}
    end
   private
    InvocationsBaseDir = File.expand_path('../../invocations',File.dirname(__FILE__))
    def set_defaults()
      self[:invocations_base_dir] = InvocationsBaseDir
    end
  end
end
