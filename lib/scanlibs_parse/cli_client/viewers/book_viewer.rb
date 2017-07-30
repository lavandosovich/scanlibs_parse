module ScanlibsParse
  module CLI
    module Viewer
      class Book < Object
        def self.call(book, index)
          super book, index
          puts"BOOK  #{@start_string}  -  #{book.date}  -  #{book.pages}.p"
        end
      end
    end
  end
end