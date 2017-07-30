module ScanlibsParse
  module CLI
    module Viewer
      class Video < Object
        def self.call(video, index)
          super video, index
          puts"VIDEO #{@start_string}  -  #{video.duration}  -  #{video.skill_level}"
        end
      end
    end
  end
end