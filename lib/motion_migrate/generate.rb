module MotionMigrate
  class Model
    include MotionMigrate::MotionGenerate::Entity
    include MotionMigrate::MotionGenerate::Property
  end

  class Generate
    class << self
      def build
        models = Dir.glob("app/models/*.rb")
        raise "#{"-" * 112}\n--- No models defined in 'app/models', add models to this folder if you want to generate the database model. ---\n#{"-" * 112}" if models.count == 0
        
        models.each do |filename|
          File.open(filename) { |file| eval(file.read) }
        end

        builder = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
          xml.model(database_model_attributes) do
            ObjectSpace.each_object(Class).select { |klass| klass < MotionMigrate::Model }.each do |entity|
              xml.entity(:name => entity.entity_name, :representedClassName => entity.entity_name, :syncable => "YES") do
                entity.properties.each do |property|
                  xml.attribute(property)
                end
              end
            end
          end
        end
        builder.to_xml
      end

      def database_model_attributes
        {
          :name => "",
          :userDefinedModelVersionIdentifier => "",
          :type => "com.apple.IDECoreDataModeler.DataModel",
          :documentVersion => "1.0",
          :lastSavedToolsVersion => "1811",
          :systemVersion => "11D50",
          :minimumToolsVersion => "Automatic",
          :macOSVersion => "Automatic",
          :iOSVersion => "Automatic"
        }
      end
    end
  end
end
