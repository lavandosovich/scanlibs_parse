module ScanlibsParse
  module CLI
    # This class initiates CLI app launch
    class Starter
      def self.call
        MainMenu.start MainController.new
      end
    end
  end
end