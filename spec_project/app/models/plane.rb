class Plane < MotionMigrate::Model
  property :name, :string
  property :multi_engine, :boolean, :default => false
  property :first_flight_at, :date
  property :flight_info, :binary_data

  belongs_to :pilot, :class_name => "Pilot", :inverse_of => :plane, :deletion_rule => :nullify
  belongs_to :owner, :class_name => "Pilot", :inverse_of => :owned_planes, :deletion_rule => :nullify

  has_many :flown_by_pilots, :class_name => "Pilot", :inverse_of => :flown_planes, :deletion_rule => :nullify
end