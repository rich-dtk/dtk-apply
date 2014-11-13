class DTK::Converge
  class PuppetApply
    class Logfile
      BaseDir = '/var/log/puppet-startup'
      def self.processor()
        @@logfiles_base_dir = create_logfiles_base_dir?()
        self
      end

      def initialize(invocation_obj)
        @invocation_obj = invocation_obj
      end
      def self.logfile(invocation_obj)
        new(invocation_obj).logfile()
      end
      def logfile()
        file_name = "stage#{stage_num()}"
        if invocation_num() > 1
          file_name << "-#{invocation_num()}"
        end
        "#{@@logfiles_base_dir}/#{file_name}"
      end

     private
      def self.create_logfiles_base_dir?()
        Dir.mkdir(BaseDir) unless File.exists?(BaseDir)
        invocations_base_dir()
      end
      def self.invocations_base_dir()
        time = Time.new.strftime("%Y-%m-%d--%H:%M:%S")
        "#{BaseDir}/#{time}"
      end

      def invocation_num()
        @invocation_obj.invocation_num()
      end
      def stage_num()
        @invocation_obj.stage_num()
      end

    end
  end
end
