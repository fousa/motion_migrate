describe "properties in a model" do
  before do
    Plane.MR_truncateAll
  end

  it "should set the property name on the model" do
    new_plane = Plane.MR_createEntity
    new_plane.name.should == nil
    new_plane.name = "Airbus 380"
    new_plane.name.should == "Airbus 380"
    NSManagedObjectContext.contextForCurrentThread.MR_saveToPersistentStoreAndWait

    fetched_plane = Plane.MR_findFirst
    fetched_plane.name.should == "Airbus 380"
  end

  # Check data
  # Check date
  # Check boolean
end
