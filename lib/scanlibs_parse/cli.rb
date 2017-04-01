
class ScanlibsParse::CLI
  def self.call
    greetings
    list_books
  end

  def self.list_books
    puts"Here are some books: \n\n"
    @books = ScanlibsParse::Parser.get_books
    @books.each.with_index(1) do |book, index|
      puts"#{index}. #{book.name} - #{book.author} - #{book.date} - #{book.pages}.p"
    end
  end

  def self.greetings
    puts"\n\n\t\t\tWELCOME TO SCANLIB PARSER\n\n"
  end
end