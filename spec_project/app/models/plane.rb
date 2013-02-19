class Plane < MotionMigrate::Model
  property :name, :string
  property :multi_engine, :boolean, :default => false
  property :first_flight_at, :date
  property :flight_info, :binary_data
end