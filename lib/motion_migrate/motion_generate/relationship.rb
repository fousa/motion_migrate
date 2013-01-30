module MotionMigrate
  module MotionGenerate 
    module Relationship
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def belongs_to(name, options={})
          relationship(name, :belongs_to, options)
        end

        def has_many(name, options={})
          relationship(name, :has_many, options)
        end

        def relationship(name, type, options={})
          options.each { |key, value| raise_if_relationship_option_not_allowed(type, key) }

          raise_if_relationship_options_missing(options)
          raise_if_deletion_rule_not_allowed(options)

          attributes = {
            name: name,
            optional: core_data_boolean(true),
            deletionRule: core_data_string(:no_action)
          }
          attributes.merge!(core_data_relationship_attributes(type, options))
          relationships[self.entity_name] = {} if relationships[self.entity_name].nil?
          relationships[self.entity_name][name] = attributes
          attributes
        end

        def relationships
          @@relationships ||= {}
        end

        def raise_if_relationship_option_not_allowed(type, option)
          unless relationship_option_allowed?(type, option)
            raise <<-ERROR
--------------------------------------------------
---- The option must be one of the following: ----
----                                          ----
----   For type :belongs_to:                  ----
----     - :required                          ----
----     - :min                               ----
----     - :max                               ----
----     - :deletion_rule                     ----
----     - :class_name                        ----
----     - :inverse_of                        ----
----     - :syncable                          ----
----     - :spotlight                         ----
----     - :truth_file                        ----
----     - :transient                         ----
----                                          ----
----   For type :has_many:                    ----
----     - :required                          ----
----     - :min                               ----
----     - :max                               ----
----     - :deletion_rule                     ----
----     - :class_name                        ----
----     - :inverse_of                        ----
----     - :syncable                          ----
----     - :ordered                           ----
----     - :spotlight                         ----
----     - :truth_file                        ----
----     - :transient                         ----
--------------------------------------------------
            ERROR
          end
        end

        def raise_if_relationship_options_missing(options)
          unless relationship_options_complete?(options)
            raise <<-ERROR
--------------------------------------------------
---- One of these options are required: ----
----     - :class_name                        ----
----     - :inverse_of                        ----
--------------------------------------------------
            ERROR
          end
        end

        def deletion_rule_allowed?(options)
          allowed_deletion_rules = [
            :nullify,
            :cascade,
            :deny
          ]
          !options[:deletion_rule] || allowed_deletion_rules.include?(options[:deletion_rule])
        end

        def raise_if_deletion_rule_not_allowed(options)
          unless deletion_rule_allowed?(options)
            raise <<-ERROR
--------------------------------------------------
---- One of these deletion rules are allowed: ----
----     - :nullify                           ----
----     - :cascade                           ----
----     - :deny                              ----
--------------------------------------------------
            ERROR
          end
        end

        def relationship_options_complete?(options)
          required_options = [:class_name, :inverse_of]
          (required_options.uniq - options.keys.uniq).empty?
        end

        def relationship_option_allowed?(type, option)
          allowed_options = {
            has_many: [:ordered],
          }[type] || []

          allowed_options += [
            :required,
            :min,
            :max,
            :spotlight,
            :truth_file,
            :syncable,
            :transient,
            :inverse_of,
            :class_name,
            :deletion_rule
          ]
          allowed_options.include?(option)
        end

        def core_data_relationship_attributes(type, options)
          attributes = {}

          options.each do |key, value|
            case key
            when :required
              attributes[:optional] = core_data_boolean(value != true)
            when :inverse_of
              attributes[:inverseName] = value
            when :class_name
              attributes[:inverseEntity] = value
              attributes[:destinationEntity] = value
            when :deletion_rule
              attributes[:deletionRule] = core_data_string(value)
            when :transient
              attributes[:transient] = core_data_boolean(value)
            when :syncable
              attributes[:syncable] = core_data_boolean(value)
            when :spotlight
              attributes[:spotlightIndexingEnabled] = core_data_boolean(value)
            when :truth_file
              attributes[:storedInTruthFile] = core_data_boolean(value)
            when :min
              attributes[:minCount] = value
            when :max
              attributes[:maxCount] = value
            end
          end
          attributes[:toMany] = core_data_boolean(type == :has_many)
          attributes
        end
      end
    end
  end
end