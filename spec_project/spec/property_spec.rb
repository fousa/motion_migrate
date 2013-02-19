describe "properties in a model" do
  it "should set the property name on the model" do
    reset

    new_plane = Plane.MR_createEntity
    new_plane.name.should == nil
    new_plane.name = "Airbus 380"
    new_plane.name.should == "Airbus 380"
    save

    fetched_plane = Plane.MR_findFirst
    fetched_plane.name.should == "Airbus 380"
  end

  it "should set the boolean property on the model" do
    reset
    
    new_plane = Plane.MR_createEntity
    new_plane.multi_engine.boolValue.should == false
    new_plane.multi_engine = true
    new_plane.multi_engine.class.should == Fixnum
    save

    fetched_plane = Plane.MR_findFirst
    fetched_plane.multi_engine.boolValue.should == true
  end

  it "should set the date property on the model" do
    reset
    
    new_plane = Plane.MR_createEntity
    new_plane.first_flight_at.should == nil
    date = NSDate.date
    new_plane.first_flight_at = date
    new_plane.first_flight_at.should == date
    new_plane.first_flight_at.class.should == Time
    save

    fetched_plane = Plane.MR_findFirst
    fetched_plane.first_flight_at.should == date
  end

  # Check data

  def reset
    Plane.MR_truncateAll
  end

  def save
    NSManagedObjectContext.contextForCurrentThread.MR_saveToPersistentStoreAndWait
  end
end
