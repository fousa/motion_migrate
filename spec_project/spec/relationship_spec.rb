describe "relationship in a model" do
  it "should set the belongs to property both ways on the models" do
    reset

    new_plane = Plane.MR_createEntity
    new_plane.pilot.class.should == NilClass
    new_plane.name = "X1"
    new_pilot = Pilot.MR_createEntity
    new_pilot.name = "Chuck Yeager"
    new_pilot.plane.class.should == NilClass
    new_plane.pilot = new_pilot
    new_plane.pilot.name.should == new_pilot.name
    new_pilot.plane.name.should == new_plane.name
    save

    fetched_plane = Plane.MR_findFirst
    fetched_pilot = Pilot.MR_findFirst
    fetched_plane.pilot.name.should == "Chuck Yeager"
    fetched_pilot.plane.name.should == "X1"
    fetched_pilot.plane = nil
    save

    fetched_plane = Plane.MR_findFirst
    fetched_pilot = Pilot.MR_findFirst
    fetched_plane.pilot.class.should == NilClass
    fetched_pilot.plane.class.should == NilClass
  end

  it "should set the belongs to and has many relation on the models" do
    reset

    new_plane = Plane.MR_createEntity
    new_plane.owner.class.should == NilClass
    new_plane.name = "X1"
    new_other_plane = Plane.MR_createEntity
    new_other_plane.name = "P-51 Mustang"
    new_pilot = Pilot.MR_createEntity
    new_pilot.name = "Chuck Yeager"
    new_pilot.owned_planes.count.should == 0
    # Test relation belongs to property
    new_plane.owner = new_pilot
    new_plane.owner.name.should == new_pilot.name
    new_pilot.primitiveOwned_planes.count.should == 1
    new_pilot.owned_planes.allObjects.first.name.should == "X1"
    # Test relation has many addObject setter
    new_pilot.addOwned_planesObject(new_other_plane)
    new_pilot.owned_planes.allObjects.count.should == 2
    save

    fetched_plane = Plane.MR_findFirst
    fetched_pilot = Pilot.MR_findFirst
    fetched_plane.owner.name.should == "Chuck Yeager"
    fetched_pilot.owned_planes.allObjects.count.should == 2
    fetched_pilot.owned_planes.allObjects.sort_by(&:name).each do |p|
      p.name.class.should == String
    end
    fetched_pilot.removeOwned_planesObject(fetched_plane)
    fetched_pilot.owned_planes.allObjects.count.should == 1
    save

    fetched_pilot = Pilot.MR_findFirst
    fetched_pilot.owned_planes.allObjects.count.should == 1
    fetched_plane = Plane.MR_findFirst
    fetched_plane.owner.should == nil

    new_plane = Plane.MR_createEntity
    new_plane.name = "ASW-27"
    new_other_plane = Plane.MR_createEntity
    new_other_plane.name = "Diana 2"
    new_pilot = Pilot.MR_createEntity
    new_pilot.name = "Sébastien Kawa"
    new_pilot.owned_planes = NSSet.setWithArray([new_plane, new_other_plane])
    new_pilot.owned_planes.count.should == 2
    new_plane.owner.name.should == "Sébastien Kawa"
    save
  end

  it "should set the has many relation both ways on the models" do
    reset

    new_plane = Plane.MR_createEntity
    new_plane.owner.class.should == NilClass
    new_plane.name = "X1"
    new_other_plane = Plane.MR_createEntity
    new_other_plane.name = "P-51 Mustang"
    new_plane.flown_by_pilots.count.should == 0

    new_pilot = Pilot.MR_createEntity
    new_pilot.name = "Chuck Yeager"
    new_other_pilot = Pilot.MR_createEntity
    new_other_pilot.name = "Sébastien Kawa"
    new_pilot.flown_planes.count.should == 0

    new_pilot.addFlown_planesObject(new_plane)
    new_pilot.addFlown_planesObject(new_other_plane)

    new_pilot.flown_planes.allObjects.count.should == 2
    new_plane.flown_by_pilots.allObjects.count.should == 1
    new_other_plane.flown_by_pilots.allObjects.count.should == 1
    new_other_pilot.addFlown_planesObject(new_plane)
    new_other_pilot.flown_planes.count.should == 1
    new_plane.flown_by_pilots.allObjects.count.should == 2
    save
  end
end
