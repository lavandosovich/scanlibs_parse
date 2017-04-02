
class ScanlibsParse::CLI
  def self.call
    greetings
    list_content
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
    puts"#{index}. #{book.name[0..20]}... - #{book.author} - #{book.date} - #{book.pages}.p"
  end

  def self.print_video_info(video, index)
    puts"#{index}. #{video.name[0..20]}... - #{video.format} - #{video.resolution} - #{video.duration} - #{video.skill_level}"
  end
end