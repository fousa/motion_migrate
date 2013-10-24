module MotionMigrate
  module MotionGenerate
    module Parser
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def core_data_string(string)
          string.to_s.split("_").each{|word| word.capitalize! }.join(" ")
        end

        def core_data_variable(value)
          value.to_s.split("_").each{ |word| word.capitalize! }.join("")
        end

        def core_data_boolean(value)
          value == true ? "YES" : "NO"
        end

        def core_data_date(value)
          (value.to_time.to_i - Date.new(2001, 1, 1).to_time.to_i).to_s
        end
      end
    end
  end
end
