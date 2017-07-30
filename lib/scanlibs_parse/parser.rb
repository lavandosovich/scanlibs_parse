require 'httparty'
require 'nokogiri'
require 'pry'

module ScanlibsParse
  # Parser algorithm for Scanlibs
  class Parser

    SCANLIBS_ADDRESS = 'https://scanlibs.com/'

    def self.content
      form_content
    end

    def self.parse_params
      @data = []
      raw_books_and_videos.each_with_index do |content, index|
        link = link_data content
        @data[index] = { type: nil, content: {} }
        @data[index][:content][:name] = get_name link
        @data[index][:content][:link] = get_link link
        parsed_info = distinguish_info(content.css('.entry-content'))
        @data[index][:type] = parsed_info[0]
        parsed_info[1].each do |key, value|
          @data[index][:content][key] = value
        end
      end
      @data
    end

    def self.link_data content
      content.css('.blog-item-wrap').css('a')
    end

    def self.get_name content
      content
          .attr('title')
          .value
    end

    def self.get_link content
      content
          .attr('href')
          .value
    end

    def self.raw_books_and_videos
      response = HTTParty.get(SCANLIBS_ADDRESS)
      Nokogiri::HTML(response).css('.site-main').css('article')
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
      is_a_video = valid_content.include?("Skill level")
      if is_a_video
        VideoFormer.call(valid_content)
      else
        BookFormer.call(valid_content)
      end
    end

    def self.tame_content(content)
      content.text.tr("\n", ' ').tr("\t", '')
    end
  end
end