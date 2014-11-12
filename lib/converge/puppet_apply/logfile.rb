class DTK::Converge
  class PuppetApply
    class Logfile
      BaseDir = '/var/log/puppet-startup'
      def initialize()
        @logfiles_base_dir = create_logfiles_base_dir?()
      end
     private
      def create_logfiles_base_dir?()
        Dir.mkdir(BaseDir) unless File.exists?(BaseDir)
        invocations_base_dir()
      end
      def invocations_base_dir()
        time = Time.new.strftime("%Y-%m-%d--%H:%M:%S")
        "#{BaseDir}/#{time}"
      end

      def logfile(invocation_obj)
        file_name = "stage#{invocation_obj.stage_num}"
        if invocation_num.to_i > 1
          file_name << "-#{invocation_objinvocation_num}"
        end
        "#{@logfiles_base_dir}/#{file_name}"
      end

    end
  end
end
