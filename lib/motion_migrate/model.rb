module MotionMigrate
  class Model < NSManagedObject
    include MotionMigrate::MotionModel::Property
    include MotionMigrate::MotionModel::Relationship

    def inspect
      # Show entity with fields
    end
  end
end