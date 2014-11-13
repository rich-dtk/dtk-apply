module DTK; class Converge
  class PuppetApply < self
    require File.expand_path('puppet_apply/invocation',File.dirname(__FILE__))
    require File.expand_path('puppet_apply/logfile',File.dirname(__FILE__))

    def initialize()
      @invocation_objects = Invocation.ordered_objects()
      @logfile_processor = (Logfile.processor() unless Config[:logging] == 'off')
    end

    def run()
      require_puppet?()
      @invocation_objects.each do |invocation_obj|
        puppet_apply(invocation_obj)
      end
    end

   private
    def require_puppet?()
      unless mock_mode?
        unless @puppet_loaded
          require 'puppet'
          @puppet_loaded = true
        end
      end
    end

    def puppet_apply(invocation_obj)
      logfile = @logfile_processor && @logfile_processor.logfile(invocation_obj)
      manifest_file = invocation_obj.manifest_file
      cmd_line = 
        [
         "apply", 
         manifest_file,
         logfile && "-l", logfile,
         "-d"
        ].compact
      cmd = "/usr/bin/puppet" 
      print_command(cmd,cmd_line)
      return if mock_mode?
     begin
       ::Puppet::Node::Environment.clear()
       Thread.current[:known_resource_types] = nil
       ::Puppet::Util::CommandLine.new(cmd,cmd_line).execute
      rescue SystemExit => exit
       exit_status = exit.status
       if exit_status == 0
         puts "exit status = #{exit_status}\n"
       else
         raise Error.new("Bad exist status #{exit_status}")
       end
      ensure
      ::Puppet::Util::Log.close_all()
     end
    end

    def mock_mode?()
      Config[:mock_mode]
    end

    def print_command(cmd,cmd_line)
      puts "Executing #{cmd} #{cmd_line.join(' ')}\n"
    end
  end
end; end
