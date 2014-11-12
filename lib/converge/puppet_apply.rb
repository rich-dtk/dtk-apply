require 'puppet'
class DTK::Converge
  class PuppetApply < self
  require File.expand_path('invocation',File.dirname(__FILE__))
  require File.expand_path('logfile',File.dirname(__FILE__))
    def self.run(opts={})
      new(opts).run()
    end
    def run()
      @invocation_objects.each do |invocation_obj|
        puppet_apply(invocation_obj)
      end
    end
   private
    def initialize(opts={})
      @invocation_objects = Invocation.ordered_objects()
      @logfile_object = (LogFile.new unless @config[:logging] == 'off')
    end

    def puppet_apply(invocation_obj)
      logfile = @logfile_object.logfile(invocation_obj)
      manifest_file = invocation_obj.manifest_file
      cmd_line = 
        [
         "apply", 
         invocation_obj,
         logfile && "-l", logfile,
         "-d"
        ].compact
      cmd = "/usr/bin/puppet" 
     begin
       ::Puppet::Node::Environment.clear()
       Thread.current[:known_resource_types] = nil
       pp "Executing #{cmd} #{cmd_line.join(' ')}"
       #    ::Puppet::Util::CommandLine.new(cmd,cmd_line).execute
      rescue SystemExit => exit
       exit_status = exit.status
       if exit_status == 0
         pp "exit status = #{exit_status}"
       else
         raise "Bad exist status #{exit_status}"
       end
      ensure
       ::Puppet::Util::Log.close_all()
     end
    end
  end
end
