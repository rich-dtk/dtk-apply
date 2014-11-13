class DTK::Converge
  class PuppetApply
    class Invocation
      attr_reader :manifest_file,:stage_num,:invocation_num
      def initialize(manifest_file)
        # should have form such as site-stage-1-invocation-1.pp
        unless manifest_file =~ /site-stage-([0-9]+)-invocation-([0-9]+)\.pp$/
          raise "Manifest File (#{manifest_file}) has wrong syntax"
        end
        @stage_num = $1.to_i
        @invocation_num = $2.to_i
        @manifest_file = fully_qualify(manifest_file)
      end

      def self.ordered_objects()
        pp_files = Dir.entries(invocations_base_dir()).select{|f|f =~ /\.pp$/}
        order(pp_files.map{|path|Invocation.new(path)})
      end

     private
      def invocations_base_dir()
        self.class.invocations_base_dir()
      end
      def self.invocations_base_dir()
        @invocations_base_dir ||= DTK::Converge.invocations_base_dir()
      end
      
      def self.order(invocation_objs)
        invocation_objs.sort do |a,b|
          ret = a.stage_num <=> b.stage_num
          if ret == 0
            ret = a.invocation_num <= b.invocation_num 
          end
          ret
        end
      end

      def fully_qualify(path)
        "#{invocations_base_dir()}/#{path}"
      end

    end
  end
end    
