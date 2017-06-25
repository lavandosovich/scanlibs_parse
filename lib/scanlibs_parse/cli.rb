
class ScanlibsParse::CLI
  @@string_to_full = " "*15

  def self.call
    greetings
    list_content
    menu
  end

  def self.list_content
    puts"Here are some books: \n\n"
    @vessel = ScanlibsParse::Parser.content
    @vessel.each.with_index(1) do |atom, index|
      if atom.class == Book
        print_book_info(atom, index)
      else
        print_video_info(atom, index)
      end
    end
  end

  def self.greetings
    puts"\n\n\t\t\tWELCOME TO SCANLIB PARSER\n\n"
  end

  def self.print_book_info(book, index)
    start_of_string =
        "#{index}. #{book.name}#{@@string_to_full}"[0..30]
    puts"BOOK  #{start_of_string}  -  #{book.date}  -  #{book.pages}.p"
  end

  def self.print_video_info(video, index)
    start_string =
        "#{index}. #{video.name}#{@@string_to_full}"[0..30]
    puts"VIDEO #{start_string}  -  #{video.duration}  -  #{video.skill_level}"
  end

  def self.menu
    input = nil
    until input == 'exit' do
      puts "\nChoose interesting content:\n\n"
      puts '*** Small notice:'
      puts '***'
      puts '***   if u wanna to proceed after browsing some content'
      puts "***   close opened web-browser.\n\n"
      print'> '
      input = gets.strip.to_i
      system("sensible-browser #{@vessel[input-1].link}") unless input == 'exit'
    end
  end
end