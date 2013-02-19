describe "relationship in a model" do
  it "should set the belongs to property both ways on the model" do
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

  # test belongs to - has isToMany
  # test has many has many

  def reset
    Plane.MR_truncateAll
    Pilot.MR_truncateAll
  end

  def save
    NSManagedObjectContext.contextForCurrentThread.MR_saveToPersistentStoreAndWait
  end
end
