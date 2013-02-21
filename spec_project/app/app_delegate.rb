class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("MotionMigrateSpec.sqlite")
    
    true
  end
end
