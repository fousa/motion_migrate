module MotionMigrate
  class Model < NSManagedObject
    include MotionModel::Property

    def inspect
      # Show entity with fields
    end
  end
end