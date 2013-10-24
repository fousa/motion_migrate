class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    if RUBYMOTION_ENV == 'test'
      MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("MotionMigrateSpec.sqlite")
    else
      MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("MotionMigrateExample.sqlite")
    end

    initialize_data

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    controller = PlanesViewController.new
    navigation_controller = UINavigationController.alloc.initWithRootViewController(controller)
    @window.rootViewController = navigation_controller
    @window.makeKeyAndVisible

    true
  end

  def initialize_data
    MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait(lambda do |local_context|
      Plane.MR_truncateAll
      Pilot.MR_truncateAll

      buck = Pilot.MR_createInContext(local_context)
      buck.name = "Buck Danny"
      sonny = Pilot.MR_createInContext(local_context)
      sonny.name = "Sonny Tuckson:"
      jerry = Pilot.MR_createInContext(local_context)
      jerry.name = "Jerry Tumbler"

      x = Plane.MR_createInContext(local_context)
      x.name = "Bell X-1"
      tomcat = Plane.MR_createInContext(local_context)
      tomcat.name = "Grumman F-14 Tomcat"
      hornet = Plane.MR_createInContext(local_context)
      hornet.name = "McDonnell Douglas F/A-18 Hornet"

      x.addFlown_by_pilotsObject buck

      tomcat.addFlown_by_pilotsObject buck
      tomcat.addFlown_by_pilotsObject sonny

      hornet.addFlown_by_pilotsObject buck
      hornet.addFlown_by_pilotsObject sonny
      hornet.addFlown_by_pilotsObject jerry
    end)
  end
end
