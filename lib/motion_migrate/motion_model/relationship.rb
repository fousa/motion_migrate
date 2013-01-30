module MotionMigrate
  module MotionModel 
    module Relationship
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def belongs_to(name, options={})
        end

        def has_many(name, options={})
        end
        
        def belongs_to(name, options={})
        end
      end
    end
  end
end
