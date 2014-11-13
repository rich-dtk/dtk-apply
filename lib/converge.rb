module DTK
  class Converge
    require File.expand_path('converge/puppet_apply',File.dirname(__FILE__))
    require File.expand_path('converge/config',File.dirname(__FILE__))

    def self.create(type,hash_options={})
      Config.set_from_hash(hash_options)
      case type
        when :puppet_apply then PuppetApply.new()
      else
        raise Error.new("Illegal type #{type}")
      end
    end
  end

  class Error < Exception
  end
end

