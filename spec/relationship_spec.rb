require "motion_migrate/motion_generate/entity"
require "motion_migrate/motion_generate/parser"
require "motion_migrate/motion_generate/property"
require "motion_migrate/motion_generate/relationship"
require "motion_migrate/generate"

module MotionMigrate
  describe "relationship definitions in the model" do
    before do
      @allowed_options = {
        required: true,
        transient: true,
        class_name: "Test",
        inverse_of: "test",
        deletion_rule: :cascade,
        min: "1",
        max: "2",
        spotlight: true,
        truth_file: true,
        syncable: true
      }
      @filled_allowed_attributes = {
        optional: "NO",
        transient: "YES",
        inverseEntity: "Test",
        destinationEntity: "Test",
        inverseName: "test",
        deletionRule: "Cascade",
        minCount: "1",
        maxCount: "2",
        spotlightIndexingEnabled: "YES",
        storedInTruthFile: "YES",
        syncable: "YES"
      }
    end

    %w(belongs_to has_many).each do |type|
      it "should error on incomplete options for #{type}" do
        lambda { MotionMigrate::Model.send(type, :field) }.should raise_error
      end

      it "should error on undiffened options for #{type}" do
        lambda { MotionMigrate::Model.send(type, :field, :class_name => "Test", :inverse_of => "test", :unknown => true) }.should raise_error
      end

      it "should error on undiffened deletion rules for #{type}" do
        lambda { MotionMigrate::Model.send(type, :field, :class_name => "Test", :inverse_of => "test", :deletion_rule => :unknown) }.should raise_error
      end
    end

    it "should return the correct options for belongs_to" do
      MotionMigrate::Model.belongs_to(:field, @allowed_options).should == @filled_allowed_attributes.merge({ :toMany => "NO", :name => :field })
    end

    it "should return the correct options for has_many" do
      MotionMigrate::Model.has_many(:field, @allowed_options).should == @filled_allowed_attributes.merge({ :toMany => "YES", :name => :field })
    end
  end
end
