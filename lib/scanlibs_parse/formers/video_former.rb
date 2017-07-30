module ScanlibsParse
  # Form Video from dirty text data
  class VideoFormer
    FORMAT     = /\| (\w*) \| AVC/
    RESOLUTION = /\| AVC (\d*.\d*)/
    DURATION   = /AAC .* \| (.*) \| .* eLearning/
    SIZE       = /\| (.{1,5}) (GB|MB) eLearning/
    SKILL_LVL  = /\| Skill level: (\w*\s?\w*)/
    TYPE       = 'video'.freeze

    class << self
      def call(filth_video)
        { type: TYPE,
          content:
              { format: FORMAT.match(filth_video)[1],
                resolution: RESOLUTION.match(filth_video)[1],
                duration: DURATION.match(filth_video)[1],
                size: SIZE.match(filth_video)[1..-1],
                skill_level: SKILL_LVL.match(filth_video)[1] } }
      end
    end
  end
end