class Plane < MotionMigrate::Model
  property :name, :string
  property :multi_engine, :boolean, :default => false
end