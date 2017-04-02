require 'httparty'
require 'nokogiri'
require 'pry'

class ScanlibsParse::Parser
  SCANLIBS_ADDRESS = 'https://scanlibs.com/'
  def self.content
    form_content
  end

  def self.parse_params
    @data = []
    response = HTTParty.get(SCANLIBS_ADDRESS)
    @books_and_videos = Nokogiri::HTML(response).css('.post-inner-content')
    @books_and_videos.each_with_index do |content, index|
      @data[index] = {type: nil, content: {}}
      @data[index][:content][:name] = content.css('.entry-title').text
      content_info = content.css('.entry-content')
      parsed_info = distinguish_info(content_info)
      @data[index][:type] = parsed_info[0]
      parsed_info[1].each do |key, value|
        @data[index][:content][key] = value
      end
    end
    @data
  end

  def self.form_content(params = self.parse_params)
    content = []
    params.each do |param|
      atom = if param[:type] == 'book'
               Book.new(param[:content])
             else
               Video.new(param[:content])
             end
      content << atom
    end
    content
  end

  def self.distinguish_info entry_content
    book(entry_content) || video(entry_content)
  end

  def self.book content
    valid_content = content.text
    book = /Author: (.*)Pub Date: (\d*)ISBN: \d*-\d*Pages: (\d*)/.
        match(valid_content)
    return nil unless book
    [
      'book',
      { date: book[2],
        pages: book[3],
        author: book[1] }
    ]
  end

  def self.video content
    valid_content = content.text.tr("\n", ' ')
    video = /\w* \| (\w*) \| AVC (.*) \| AAC .* \| (.*) \| (\d*) (MB|BG) \w* \| Skill level: (\w* \w*)/.
        match(valid_content)
    [
      'video',
      { format: video[1],
        resolution: video[2],
        duration: video[3],
        size: [video[4], video[5]],
        skill_level: video[6] }
    ]
  end
end