module ScanlibsParse
  module CLI
    # Main controller responsible for operations in CLI client
    class MainController
      attr_reader :book_viewer, :video_viewer, :parser

      def initialize(
          book_viewer  = Viewer::Book,
          video_viewer = Viewer::Video,
          parser       = ScanlibsParse::Parser
      )
        @parser         = parser
        @book_viewer    = book_viewer
        @video_viewer   = video_viewer
      end

      def list_articles
        puts"Here are some books: \n\n"
        parser.articles.each.with_index(1) do |article, index|
          if article.class == Book
            book_viewer.call article, index
          else
            video_viewer.call article, index
          end
        end
      end

      def print_pages_amount
        puts "Amount of pages: #{@parser.number_of_pages}"
      end

      def visit_article
        system("sensible-browser #{articles[input.to_i-1].link}") unless input == 'exit'
      end
    end
  end
end