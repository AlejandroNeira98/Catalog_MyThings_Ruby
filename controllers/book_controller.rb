require './models/book'
require 'date'

class BookController
  attr_accessor :books

  def initialize
    @books = []
  end

  def list
    puts "Id\t\tPublish date\tArchived\tPublisher\tCover state\tLabel\n#{['-'] * 90 * ''}"
    @books.each do |book|
      puts "#{book.id}\t#{book.publish_date}\t" \
           "#{book.archived}\t\t" \
           "#{book.publisher}\t" \
           "#{book.cover_state}\t\t" \
           "\033[#{COLOR_CODES[book.label.color]}m#{book.label.title}\033[0m"
    end
    puts ''
  end

  def add
    puts 'Publish date (YYYY-MM-DD):'
    date = Date.parse(gets.chomp)
    puts 'Is it archived(y/n)?:'
    archived = gets.chomp == 'y'
    puts 'Publisher:'
    publisher = gets.chomp
    puts 'Cover state:'
    cover_state = gets.chomp
    book = Book.new(date, archived, publisher, cover_state)
    @books << book

    book
  end
end
