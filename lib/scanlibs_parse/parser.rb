require 'httparty'
require 'nokogiri'
require 'pry'

class ScanlibsParse::Parser
  SCANLIBS_ADDRESS = 'https://scanlibs.com/'
  def self.get_books
    form_books
  end

  def self.parse_params
    @data = []
    response = HTTParty.get(SCANLIBS_ADDRESS)
    @books = Nokogiri::HTML(response).css('.post-inner-content')
    @books.each_with_index do |book,index|
      @data[index] = {}
      @data[index][:name] = book.css('.entry-title').text
      book_info = book.css('.entry-content')
      parsed_info = distinguish_info(book_info) || []
      @data[index][:date] = parsed_info[2]
      @data[index][:pages] = parsed_info[3]
      @data[index][:author] = parsed_info[1]
    end
    @data
  end

  def self.form_books(params = self.parse_params)
    books = []
    params.each do |param|
      books << Book.new(param)
    end
    books
  end

  def self.distinguish_info entry_content
    data = /Author: (.*)Pub Date: (\d*)ISBN: \d*-\d*Pages: (\d*)/.match(entry_content.text)
    data
    #binding.pry
  end
end