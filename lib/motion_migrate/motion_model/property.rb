module MotionMigrate
  module MotionModel 
    module Property
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def property(name, type, options={})
        end
      end
    end
  end
end
