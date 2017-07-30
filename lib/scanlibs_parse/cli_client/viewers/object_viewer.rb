module ScanlibsParse
  module CLI
    module Viewer
      class Object
        STRING_TO_FULL = ' ' * 15
        def self.call(object, index)
          @start_string  = "#{index}. "
          @start_string += "#{object.name}#{STRING_TO_FULL}"[0..30]
        end
      end
    end
  end
end