require 'date'
require_relative './models/music_album'
require './models/book'
require './models/label'

COLOR_CODES = {
  'black' => 30,
  'red' => 31,
  'green' => 32,
  'yellow' => 33,
  'blue' => 34,
  'pink' => 35,
  'cyan' => 36,
  'white' => 37,
  'default' => 39
}.freeze

class App
  def initialize
    @music_albums = []
    @books = []
    @labels = [Label.new('Broken', 'red')]
  end

  def list_all_books
    raise StandardError, 'not implemented'
  end

  def list_all_music_albums
    @music_albums.each_with_index do |album, index|
      puts ''
      print "#{index + 1} => Released On: #{album.publish_date}  |*_*|  Archived: #{album.archived ? 'Yes' : 'No '}"
      print "  |*_*|  On Spotify: #{album.on_spotify ? 'Yes' : 'No'}"
      puts ''
    end
  end

  def list_all_movies
    raise StandardError, 'not implemented'
  end

  def list_of_games
    raise StandardError, 'not implemented'
  end

  def list_all_genres
    raise StandardError, 'not implemented'
  end

  def list_all_labels
    raise StandardError, 'not implemented'
  end

  def list_all_authors
    raise StandardError, 'not implemented'
  end

  def list_all_sources
    raise StandardError, 'not implemented'
  end

  def select_label
    puts "  \t|id\t\t|title\t\t|color\n#{['-'] * 50 * ''}"
    @labels.each_with_index do |label, i|
      puts "#{i})\t#{label.id}\t#{label.title}\t\t\033[#{COLOR_CODES[label.color]}m#{label.color}\033[0m"
    end
    puts "#{@labels.length})\t+ Add label"
    puts 'Select a label:'
    label = @labels[gets.to_i]
    if label.nil?
      puts 'Tile:'
      title = gets.chomp
      puts 'Color(black/red/green/yellow/blue/pink/cyan/white/default):'
      color = gets.chomp
      color = 'default' if COLOR_CODES[color].nil?
      label = Label.new(title, color)
    end
    @labels << label
    label
  end

  def add_a_book
    puts 'Publish date (YYYY-MM-DD):'
    date = Date.parse(gets.chomp)
    puts 'Is it archived(y/n)?:'
    archived = gets.chomp == 'y'
    puts 'Publisher:'
    publisher = gets.chomp
    puts 'Cover state:'
    cover_state = gets.chomp
    book = Book.new(date, archived, publisher, cover_state)
    label = select_label
    label.add_item(book)
  end

  def add_a_music_album
    puts ''
    puts 'Date of Album (YYYY-MM-DD): '
    date = gets.chomp
    d = Date.parse(date)
    puts 'Is Album Archived(y/n)?'
    archived = gets.chomp
    puts 'Is Album on Spotify(y/n)?'
    on_spotify = gets.chomp
    music_album = MusicAlbum.new(d, archived == 'y', on_spotify == 'y')
    @music_albums << music_album
  end

  def add_a_movie
    raise StandardError, 'not implemented'
  end

  def add_a_game
    raise StandardError, 'not implemented'
  end
end
