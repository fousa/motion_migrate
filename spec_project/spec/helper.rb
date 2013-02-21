def reset
  Plane.MR_truncateAll
  Pilot.MR_truncateAll
end

def save
  NSManagedObjectContext.contextForCurrentThread.MR_saveToPersistentStoreAndWait
end
