module Spec
  module Expectations
    module Matchers
      
      class Has #:nodoc:
        def initialize(sym, *args)
          @sym = sym
          @args = args
        end
        
        def matches?(target)
          @target = target
          Spec::Expectations.fail_with("target does not respond to ##{predicate.to_s}") unless @target.respond_to?(predicate)
          return target.send(predicate, *@args)
        end
        
        def failure_message
          "expected ##{predicate}(#{@args[0].inspect}) to return true, got false"
        end
        
        def negative_failure_message
          "expected ##{predicate}(#{@args[0].inspect}) to return false, got true"
        end
        
        def description
          "have key #{@args[0].inspect}"
        end
        
        private
          def predicate
            "#{@sym.to_s.sub("have_","has_")}?".to_sym
          end
          
      end
   
    end
  end
end
