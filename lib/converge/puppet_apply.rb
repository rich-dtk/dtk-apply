#require 'puppet'
require 'pp'
class DTK::Converge
  class PuppetApply < self
  require File.expand_path('puppet_apply/invocation',File.dirname(__FILE__))
  require File.expand_path('puppet_apply/logfile',File.dirname(__FILE__))
    def self.run(opts={})
      new(opts).run()
    end
    def run()
      @invocation_objects.each do |invocation_obj|
        puppet_apply(invocation_obj)
      end
    end
   private
    def initialize(hash_options={})
      super(hash_options)
      # TODO: pass config into everything
      @invocation_objects = Invocation.ordered_objects()
      @logfile_processor = (Logfile.processor() unless config[:logging] == 'off')
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
     begin
       #::Puppet::Node::Environment.clear()
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
      # ::Puppet::Util::Log.close_all()
     end
    end
  end
end
