module ScanlibsParse
  # Form Book from dirty text data
  class BookFormer
    REGEXP    = /Author: (.*)Pub Date: (\d*)ISBN: .*Pages: (\d*)/
    RU_REGEXP = /Автор: (.*)Год: (\d*)ISBN: .*Страниц: (\d*)/
    class << self
      def call(filth_book)
        book = REGEXP.match(filth_book) || RU_REGEXP.match(filth_book)

        { type: 'book',
          content:
              { date: book[2],
                pages: book[3],
                author: book[1] } }
      end
    end
  end
end