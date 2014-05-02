module Florrick
  module ActiveRecordExtension
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    def string_interpolation_value_for(var)
      if self.class.florrick_fields[:strings].keys.include?(var.to_sym)
        block = self.class.florrick_fields[:strings][var.to_sym]
        if block
          self.instance_eval(&block)
        else
          self.send(var)
        end
      else
        false
      end
    end
    
    module ClassMethods

      #
      # Return a hash for all florrick fields which have been defined for this model
      #
      def florrick_fields
        @florrick_fields ||= {:strings => {}, :relationships =>{}}
      end
      
      #
      # Accept a new set of configuration for this model
      #
      def florrick(&block)
        dsl = Florrick::DSL.new(self)
        dsl.instance_eval(&block)
        dsl
      end
      
      #
      # Return whether or not a given key can be replaced
      #
      def string_interpolation_for?(var)
        florrick_fields[:strings].keys.include?(var.to_sym)
      end
      
      #
      # Return whether or not a given relationship key can be replaced 
      #
      def string_interpolation_relationship_for?(var)
        florrick_fields[:relationships].keys.include?(var.to_sym)
      end
    end
    
  end
end
