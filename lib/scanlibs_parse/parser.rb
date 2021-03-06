require 'httparty'
require 'nokogiri'
require 'pry'

module ScanlibsParse
  # Parser algorithm for Scanlibs
  class Parser

    SCANLIBS_ADDRESS = 'https://scanlibs.com/'.freeze

    class << self
      def articles
        form_articles
      end

      def parse_articles
        page = SCANLIBS_ADDRESS
        articles = []
        raw_books_and_videos(page).each_with_index do |content, index|
          articles[index] = parse_article(content)
        end
        articles
      end

      def parse_article(content)
        link = link_data content
        article = { type: nil, content: {} }
        article[:content][:name] = get_name link
        article[:content][:link] = get_link link
        parsed_info = distinguish_info(content.css('.entry-content'))
        article[:type] = parsed_info[:type]
        parsed_info[:content].each do |key, value|
          article[:content][key] = value
        end
        article
      end

      def number_of_pages
        page = get_page SCANLIBS_ADDRESS
        Nokogiri::HTML(page).css('.nav-links .page-numbers')[-2].text
      end

      def link_data(content)
        content.css('.blog-item-wrap').css('a')
      end

      def get_name(content)
        content.attr('title').value
      end

      def get_link(content)
        content.attr('href').value
      end

      def raw_books_and_videos(page)
        page = get_page page
        Nokogiri::HTML(page).css('.site-main').css('article')
      end

      def get_page(page)
        HTTParty.get(page)
      end

      def form_articles
        content = []
        parse_articles.each do |article|
          product = if article[:type] == 'book'
                      Book.new(article[:content])
                    else
                      Video.new(article[:content])
                    end
          content << product
        end
        content
      end

      def distinguish_info(entry_content)
        valid_content = tame_content entry_content
        is_a_video = valid_content.include?('Skill level')
        if is_a_video
          VideoFormer.call(valid_content)
        else
          BookFormer.call(valid_content)
        end
      end

      def tame_content(content)
        content.text.tr("\n", ' ').tr("\t", '')
      end
    end
  end
end