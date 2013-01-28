namespace :db do
    desc "Generate a version of the current database model as described in the models."
    task :migrate do
    end

    desc "Go back to the previous version of the database model."
    task :rollback do
    end

    desc "Dump the current version of the database model scheme."
    task :schema do
    end

    desc "Show the current version of the database model scheme."
    task :version do
    end
end