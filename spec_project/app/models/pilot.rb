class Pilot < MotionMigrate::Model
  property :name, :string
  property :profile, :transformable, transformer_name: 'HashTransformer'

  belongs_to :plane, :class_name => "Plane", :inverse_of => :pilot, :deletion_rule => :nullify
  has_many :owned_planes, :class_name => "Plane", :inverse_of => :owner, :deletion_rule => :nullify
  has_many :flown_planes, :class_name => "Plane", :inverse_of => :flown_by_pilots, :deletion_rule => :nullify
end
