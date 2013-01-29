require "nokogiri"

require "motion_migrate/motion_generate/entity"
require "motion_migrate/motion_generate/property"
require "motion_migrate/generate"
require "motion_migrate/motion_generate/io"

namespace :db do
  desc "Generate a version of the current database model as described in the models."
  task :migrate do
    schema_xml = MotionMigrate::Generate.build
    MotionMigrate::IO.write(schema_xml)
  end

  desc "Go back to the previous version of the database model."
  task :rollback do
  end

  desc "Dump the current version of the database model scheme."
  task :schema do
  end

  desc "Show the current version of the database model scheme."
  task :version do
    if version = MotionMigrate::IO.current_schema_version
      puts "--- Data model is currently at version #{version}."
    else
      puts "--- No schema found in this project."
    end
  end
end
