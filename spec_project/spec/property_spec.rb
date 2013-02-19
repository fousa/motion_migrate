describe "properties in a model" do
  it "should set the property name on the model" do
    Plane.MR_truncateAll

    new_plane = Plane.MR_createEntity
    new_plane.name.should == nil
    new_plane.name = "Airbus 380"
    new_plane.name.should == "Airbus 380"
    NSManagedObjectContext.contextForCurrentThread.MR_saveToPersistentStoreAndWait

    fetched_plane = Plane.MR_findFirst
    fetched_plane.name.should == "Airbus 380"
  end

  it "should set the boolean property on the model" do
    Plane.MR_truncateAll
    
    new_plane = Plane.MR_createEntity
    new_plane.multi_engine.boolValue.should == false
    new_plane.multi_engine = true
    new_plane.multi_engine.boolValue.should == true
    NSManagedObjectContext.contextForCurrentThread.MR_saveToPersistentStoreAndWait

    fetched_plane = Plane.MR_findFirst
    fetched_plane.multi_engine.boolValue.should == true
  end

  # Check date
end
