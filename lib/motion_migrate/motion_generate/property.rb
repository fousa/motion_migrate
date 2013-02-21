module MotionMigrate
  module MotionGenerate 
    module Property
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def property(name, type, options={})
          type = type.to_sym

          raise_if_property_type_not_allowed(type)
          options.each { |key, value| raise_if_property_option_not_allowed(type, key) }

          attribute_type = type == :binary_data ? "Binary" : core_data_string(type)
          attributes = {
            name: name,
            attributeType: attribute_type,
            optional: core_data_boolean(true),
            syncable: core_data_boolean(true)
          }
          attributes.merge!(core_data_property_attributes(type, options))
          properties[self.entity_name] = {} if properties[self.entity_name].nil?
          properties[self.entity_name][name] = attributes
          attributes
        end

        def properties
          @@properties ||= {}
        end

        def raise_if_property_type_not_allowed(type)
          unless property_type_allowed?(type)
            raise <<-ERROR
! The type must be one of the following: 
!  :string                   
!  :integer_16                
!  :integer_32                 
!  :integer_64                  
!  :decimal                      
!  :double                        
!  :float                          
!  :boolean                          
!  :date                            
!  :binary_data                       
            ERROR
          end
        end

        def property_type_allowed?(type)
          [
            :string, 
            :integer_16, 
            :integer_32, 
            :integer_64, 
            :decimal, 
            :double, 
            :float, 
            :boolean, 
            :date, 
            :binary_data 
          ].include?(type)
        end

        def raise_if_property_option_not_allowed(type, option)
          unless property_option_allowed?(type, option)
            raise <<-ERROR
! The option must be one of the following:                                              
!
!   For type :string:                                                                  
!     :min                                                                    
!     :max                                                                     
!     :default                                                                  
!     :regex                                                                     
!
!   For type :boolean:                                                            
!      :default                                                                    
!
!   For type :date, :integer_16, :integer_32, :integer_64, :decimal, :double or :float: 
!      :min                           
!      :max                            
!      :default                         
!
!   For type :binary_data:               
!      :external_storage                  
!
!   Options allowed for all types:         
!      :required                            
!      :transient                                
!      :indexed                                 
!      :spotlight                              
!      :truth_file                            
            ERROR
          end
        end

        def property_option_allowed?(type, option)
          type = :number if [
            :integer_16, 
            :integer_32, 
            :integer_64, 
            :decimal, 
            :double, 
            :float,
            :date
          ].include?(type)

          allowed_options = {
            number: [:min, :max, :default],
            string: [:min, :max, :default, :regex],
            boolean: [:default],
            binary_data: [:external_storage]
          }[type]

          allowed_options += [
            :required,
            :transient,
            :indexed,
            :spotlight,
            :truth_file
          ]
          allowed_options.include?(option)
        end

        def core_data_property_attributes(type, options)
          attributes = {}

          options.each do |key, value|
            case key
            when :required
              attributes[:optional] = core_data_boolean(value != true)
            when :transient
              attributes[:transient] = core_data_boolean(value)
            when :indexed
              attributes[:indexed] = core_data_boolean(value)
            when :spotlight
              attributes[:spotlightIndexingEnabled] = core_data_boolean(value)
            when :truth_file
              attributes[:storedInTruthFile] = core_data_boolean(value)
            when :min
              if type == :date
                attributes[:minDateTimeInterval] = core_data_date(value)
              else
                attributes[:minValueString] = value
              end
            when :max
              if type == :date
                attributes[:maxDateTimeInterval] = core_data_date(value)
              else
                attributes[:maxValueString] = value
              end
            when :default
              if type == :date
                attributes[:defaultDateTimeInterval] = core_data_date(value)
              elsif type == :boolean
                attributes[:defaultValueString] = core_data_boolean(value)
              else
                attributes[:defaultValueString] = value
              end
            when :regex
              attributes[:regularExpressionString] = value
            when :external_storage
              attributes[:allowsExternalBinaryDataStorage] = core_data_boolean(value)
            end
          end
          attributes
        end
      end
    end
  end
end