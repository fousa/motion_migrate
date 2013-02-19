class Pilot < MotionMigrate::Model
  property :name, :string
  
  belongs_to :plane, :class_name => "Plane", :inverse_of => :pilot
end