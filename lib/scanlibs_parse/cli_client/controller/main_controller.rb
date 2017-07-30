module ScanlibsParse
  module CLI
    # Main controller responsible for operations in CLI client
    class MainController
      attr_reader :book_viewer, :video_viewer

      def initialize(
          book_viewer  = Viewer::Book,
          video_viewer = Viewer::Video
      )
        @book_viewer  = book_viewer
        @video_viewer = video_viewer
      end

      def list_articles
        puts"Here are some books: \n\n"
        @articles = ScanlibsParse::Parser.content
        @articles.each.with_index(1) do |article, index|
          if article.class == Book
            book_viewer.call article, index
          else
            video_viewer.call article, index
          end
        end
      end

      def visit_article
        system("sensible-browser #{@articles[input.to_i-1].link}") unless input == 'exit'
      end
    end
  end
end