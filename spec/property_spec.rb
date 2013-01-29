require 'helper'

require "motion_migrate/motion_generate/entity"
require "motion_migrate/motion_generate/property"
require "motion_migrate/generate"

module MotionMigrate
  describe "property definitions in the model" do
    before do
      @allowed_options = {
        required: true,
        transient: true,
        indexed: true,
        spotlight: true,
        truth_file: true,
        syncable: true
      }
      @filled_allowed_attributes = {
        optional: "NO",
        transient: "YES",
        indexed: "YES",
        spotlightIndexingEnabled: "YES",
        storedInTruthFile: "YES",
        syncable: "YES"
      }
    end

    %w(string integer_16 integer_32 integer_64 decimal double float date binary_data boolean).each do |type|
      it "should be able to define #{type}" do
        MotionMigrate::Model.property(:field, type).should == { :name => :field, 
                                                                :attributeType => type.split("_").each{|word| word.capitalize! }.join(" "), 
                                                                :optional=>"YES" }
      end
    end

    it "should error on undiffened types" do
      lambda { MotionMigrate::Model.property(:field, :unknown) }.should raise_error
    end

    %w(string integer_16 integer_32 integer_64 decimal double float date binary_data boolean).each do |type|
      it "should error on undiffened options for #{type}" do
        lambda { MotionMigrate::Model.property(:field, type, :unknown => true) }.should raise_error
      end
    end

    it "should return the correct options for string" do
      options = @allowed_options.merge({
        min: "1",
        max: "10",
        default: "motion",
        regex: "/we/"
      })
      MotionMigrate::Model.property(:field, :string, options).should == @filled_allowed_attributes.merge({ :name => :field, 
                                                                                                           :attributeType => "String",
                                                                                                           :minValueString => "1",
                                                                                                           :maxValueString => "10",
                                                                                                           :defaultValueString => "motion",
                                                                                                           :regularExpressionString => "/we/" })
    end

    %w(integer_16 integer_32 integer_64 decimal double float).each do |type|
      it "should return the correct options for #{type}" do
        options = @allowed_options.merge({
          min: "1",
          max: "10",
          default: "5"
        })
        MotionMigrate::Model.property(:field, type, options).should == @filled_allowed_attributes.merge({ :name => :field, 
                                                                                                          :attributeType => type.split("_").each{|word| word.capitalize! }.join(" "),
                                                                                                          :minValueString => "1",
                                                                                                          :maxValueString => "10",
                                                                                                          :defaultValueString => "5" })
      end
    end

    it "should return the correct options for boolean" do
      options = @allowed_options.merge({
        default: true
      })
      MotionMigrate::Model.property(:field, :boolean, options).should == @filled_allowed_attributes.merge({ :name => :field, 
                                                                                                            :attributeType => "Boolean",
                                                                                                            :defaultValueString => "YES" })
    end

    it "should return the correct options for binary_data" do
      options = @allowed_options.merge({
        external_storage: true
      })
      MotionMigrate::Model.property(:field, :binary_data, options).should == @filled_allowed_attributes.merge({ :name => :field, 
                                                                                                                :attributeType => "Binary Data",
                                                                                                                :allowsExternalBinaryDataStorage => "YES" })
    end

    it "should return the correct options for date" do
      options = @allowed_options.merge({
        min: DateTime.new(2013, 1, 1, 12, 0, 0),
        max: DateTime.new(2013, 1, 31, 12, 0, 0),
        default: DateTime.new(2013, 1, 5, 12, 0, 0)
      })
      MotionMigrate::Model.property(:field, :date, options).should == @filled_allowed_attributes.merge({ :name => :field, 
                                                                                                         :attributeType => "Date",
                                                                                                         :minDateTimeInterval => "378738000",
                                                                                                         :maxDateTimeInterval => "381330000",
                                                                                                         :defaultDateTimeInterval => "379083600" })
    end
  end
end

# Test all types + properties