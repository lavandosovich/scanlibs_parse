require 'httparty'
require 'nokogiri'
require 'pry'

# Parser algorithm for Scanlibs
class ScanlibsParse::Parser

  SCANLIBS_ADDRESS = 'https://scanlibs.com/'

  def self.content
    form_content
  end

  def self.parse_params
    @data = []
    raw_books_and_videos.each_with_index do |content, index|
      @data[index] = { type: nil, content: {} }
      @data[index][:content][:name] = content.css('.entry-title').text
      content_info = content.css('.entry-content')
      link = content_info.css('a').attr('href').value
      @data[index][:content][:link] = link
      parsed_info = distinguish_info(content_info)
      @data[index][:type] = parsed_info[0]
      parsed_info[1].each do |key, value|
        @data[index][:content][key] = value
      end
    end
    @data
  end

  def self.raw_books_and_videos
    response = HTTParty.get(SCANLIBS_ADDRESS)
    Nokogiri::HTML(response).css('.post-inner-content')
  end

  def self.form_content(params = parse_params)
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

  def self.distinguish_info(entry_content)
    valid_content = tame_content entry_content
    book(valid_content) || video(valid_content)
  end

  def self.book(content)
    regexp = /Author: (.*)Pub Date: (\d*)ISBN: .*Pages: (\d*)/
    book = regexp.match(content)

    return nil unless book

    [
      'book',
      { date: book[2],
        pages: book[3],
        author: book[1] }
    ]
  end

  def self.video(content)
    video =
      [
          'video',
          { format: /\| (\w*) \| AVC/.match(content)[1],
            resolution: /\| AVC (\d*.\d*)/.match(content)[1],
            duration: /AAC .* \| (.*) \| .* eLearning/.match(content)[1],
            size: /\| (.{1,5}) (GB|MB) eLearning/.match(content)[1..-1],
            skill_level: /\| Skill level: (\w*\s?\w*)/.match(content)[1] }
      ]
    video
  end

  def self.tame_content(content)
    content.text.tr("\n", ' ').tr("\t", '')
  end
end