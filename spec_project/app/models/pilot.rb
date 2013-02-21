class Pilot < MotionMigrate::Model
  property :name, :string

  belongs_to :plane, :class_name => "Plane", :inverse_of => :pilot
  has_many :owned_planes, :class_name => "Plane", :inverse_of => :owner
  has_many :flown_planes, :class_name => "Plane", :inverse_of => :flown_by_pilots
end