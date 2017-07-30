module ScanlibsParse
  module CLI
    # Class that is responsible for calling controller methods
    # Acts as router
    class MainMenu

      attr_reader :main_controller

      def self.start(main_controller)
        @menu = new main_controller
        @menu.start
      end

      def start
        greetings
        print_note
        router
      end

      private

      def initialize(main_controller)
        @main_controller = main_controller
      end

      def greetings
        puts"\n\n\t\t\tWELCOME TO SCANLIB PARSER\n\n"
      end

      def router
        user_input = nil
        until user_input == 'exit'
          print_options
          user_input = gets.strip

          case user_input
          when '1' then main_controller.list_articles
          when 'exit' then break
          else puts 'Unknown action'
          end
        end
      end

      def print_options
        puts "\nChoose option:\n\n"
        puts '1. Show articles (books and videos)'
        print "\n>"
      end

      def print_note
        puts '*** Small notice:'
        puts '***'
        puts '***   if u wanna to proceed after browsing some article'
        puts "***   close opened web-browser.\n\n"
      end
    end
  end
end