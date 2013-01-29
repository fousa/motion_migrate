module MotionMigrate
  class IO
    class << self
      def write(xml="")
        create_db

        current_schema = nil
        if version = current_schema_version()
          File.open(File.join(current_schema(), "contents")) do |f|
            current_schema = f.read
          end
        end

        if current_schema != xml
          version = (version || 0) + 1

          latest_schema_path = xcdatamodeld_path("schema.#{version}.xcdatamodel")
          Dir.mkdir(latest_schema_path) unless Dir.exists?(latest_schema_path)

          File.open(File.join(latest_schema_path, "contents"), "w") do |file|
            file.write(xml)
          end
          write_current_schema(version)

          unless File.symlink?("resources/schema.xcdatamodeld")
            File.symlink("../db/schema.xcdatamodeld", "resources/schema.xcdatamodeld")
          end

          puts "--- Data model migrated to version #{version}."
        else
          length = 38 + version.to_s.length
          puts "--- Data model already at version #{version}."
        end
      end

      def current_schema_version
        return nil unless path = current_schema

        version = nil
        path.match(/\.([0-9]+)\.xcdatamodel$/) do |match|
          version = match[1].to_i
        end
        version
      end
      
      protected

      def create_db
        FileUtils.mkdir_p(File.join("db", "schema.xcdatamodeld"))
      end

      def xcdatamodeld_path(*args)
        File.join(["db", "schema.xcdatamodeld"] + args)
      end

      def current_schema
        plist = xcdatamodeld_path(".xccurrentversion")
        return nil unless File.exists?(plist)

        xcdatamodeld_path(Nokogiri::XML(File.open(plist)).at_xpath("/plist/dict/string").text)
      end

      def write_current_schema(version)
        File.open(xcdatamodeld_path(".xccurrentversion"), "w") do |file|
          file.write(<<-PLIST)
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>_XCCurrentVersionName</key>
  <string>schema.#{version}.xcdatamodel</string>
</dict>
</plist>
          PLIST
        end
      end
    end
  end
end
