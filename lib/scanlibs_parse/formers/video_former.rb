module ScanlibsParse
  # Form Video from dirty text data
  class VideoFormer
    class << self
      def call filth_video
        [
            'video',
            { format: /\| (\w*) \| AVC/.match(filth_video)[1],
              resolution: /\| AVC (\d*.\d*)/.match(filth_video)[1],
              duration: /AAC .* \| (.*) \| .* eLearning/.match(filth_video)[1],
              size: /\| (.{1,5}) (GB|MB) eLearning/.match(filth_video)[1..-1],
              skill_level: /\| Skill level: (\w*\s?\w*)/.match(filth_video)[1] }
        ]
      end
    end
  end
end