module MotionMigrate
  class Model < NSManagedObject
    include MotionMigrate::MotionModel::Property

    def inspect
      # Show entity with fields
    end
  end
end