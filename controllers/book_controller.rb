require './models/book'
require './decorators/cell'
require 'date'

class BookController
  attr_accessor :books

  def initialize
    @books = []
  end

  def list
    puts "Id\t\tPublish date\tArchived\tPublisher\tCover state\tLabel\n#{['-'] * 96 * ''}+"
    @books.each do |book|
      puts "#{Cell.new(book.id)}" \
           "#{Cell.new(book.publish_date)}" \
           "#{Cell.new(book.archived)}" \
           "#{Cell.new(book.publisher)}" \
           "#{Cell.new(book.cover_state)}" \
           "\033[#{COLOR_CODES[book.label.color]}m#{Cell.new(book.label.title)}\033[0m"
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
