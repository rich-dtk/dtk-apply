class DTK::Converge
  class PuppetApply
    class Invocation
      attr_reader :manifest_file,:stage_num,:invocation_num
      def initialize(invocation_obj)
        # should have form such as site-stage-1-invocation-1.pp
        unless invocation_obj =~ /site-stage-([0-9]+)-invocation-([0-9]+)\.pp$/
          raise "Manifest File (#{invocation_obj}) has wrong syntax"
        end
        @stage_num,@invocation_num = [$1,$2]
        @manifest_file = fully_qualify(invocation_obj)
        @base_dir = Converge.invocations_base_dir()
      end

      def self.ordered_objects()
        pp_files = Dir.entries(@base_dir).select{|f|f =~ /\.pp$/}
        order(pp_files.map{|path|InvocationFile.new(path)})
      end

     private
      def fully_qualify(path)
        "#{@base_dir}/#{path}"
      end
      
      def order(invocation_objs)
        invocation_objs.sort do |a,b|
          ret = a.stage_num <=> b.stage_num
          if ret == 0
            ret = a.invocation_num <= b.invocation_num 
          end
          ret
        end
      end

    end
  end
end    
