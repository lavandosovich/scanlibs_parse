module ScanlibsParse
  # Form Book from dirty text data
  class BookFormer
    class << self
      def call filth_book
        regexp = /Author: (.*)Pub Date: (\d*)ISBN: .*Pages: (\d*)/
        ru_regexp = /Автор: (.*)Год: (\d*)ISBN: .*Страниц: (\d*)/

        book = regexp.match(filth_book) || ru_regexp.match(filth_book)

        [
            'book',
            { date: book[2],
              pages: book[3],
              author: book[1] }
        ]
      end
    end
  end
end