module DTK
  class Converge
    require File.expand_path('converge/puppet_apply',File.dirname(__FILE__))
    InvocationsBaseDir = File.expand_path('../invocations',File.dirname(__FILE__))
    def self.invocations_base_dir()
      InvocationsBaseDir
    end
  end
end

