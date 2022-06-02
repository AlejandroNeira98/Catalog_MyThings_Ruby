require_relative './movie'
require 'date'
require 'json'
require_relative './models/music_album'
require_relative './models/genre'
require './models/book'
require './models/label'
require './models/game'

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
    @movies = []
    @sources = []
    @music_albums = []
    @genres = []
    @books = []
    @labels = []
  end

  def list_all_books
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

  def colorize(foreground_color, text)
    "\e[#{foreground_color}m#{text}\e[0m"
  end

  def list_all_music_albums
    @music_albums.each_with_index do |album, index|
      puts ''
      print colorize(COLOR_CODES['pink'], (index + 1).to_s).to_s
      print " => #{colorize(COLOR_CODES['cyan'], 'Released On:')} #{album.publish_date}  "
      print colorize(COLOR_CODES['yellow'], '|*_*|').to_s
      print "  #{colorize(COLOR_CODES['cyan'], 'Archived:')} "
      print album.archived ? colorize(COLOR_CODES['green'], 'Yes').to_s : colorize(COLOR_CODES['red'], 'No ').to_s
      print "  #{colorize(COLOR_CODES['yellow'], '|*_*|')}  #{colorize(COLOR_CODES['cyan'], 'On Spotify:')} "
      print album.on_spotify ? colorize(COLOR_CODES['green'], 'Yes').to_s : colorize(COLOR_CODES['red'], 'No ').to_s
      print colorize(COLOR_CODES['yellow'], '  |*_*|').to_s
      print "  #{colorize(COLOR_CODES['cyan'], 'Genre')}: #{album.genre.name}"
      puts ''
    end
  end

  def list_all_movies
    @movies.each do |movie|
      puts "date: #{movie.can_be_archived?}, silent: #{movie.silent}"
    end
  end

  def list_of_games
    raise StandardError, 'not implemented'
  end

  def list_all_genres
    @genres.each_with_index do |genre, index|
      puts "#{index + 1} => #{colorize(COLOR_CODES['cayan'], genre.name)}"
    end
  end

  def list_all_labels
    formated = @labels.map do |label|
      "\033[#{COLOR_CODES[label.color]}m#{label.title}\033[0m"
    end
    puts formated.join(', ')
  end

  def list_all_authors
    raise StandardError, 'not implemented'
  end

  def list_all_sources
    @sources.each do |source|
      puts source.name.to_s
    end
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
    @books << book
    label = select_label
    label.add_item(book)
  end

  def select_genre
    puts 'What is the Genre of Album? (press 0 for creating genre)'
    puts 'No Genre Created Yet' if @genres.length.zero?
    list_all_genres
    loop do
      opt = gets.chomp.to_i
      if opt.zero?
        print 'Name of Genre: '
        name = gets.chomp
        new_genre = Genre.new(name)
        @genres << new_genre
        puts "#{@genres.length} => #{new_genre.name}"
      else
        result_genre = @genres[opt - 1]
        return result_genre unless result_genre.nil?

        puts 'Not Found!'
      end
    end
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
    genre = select_genre
    genre.add_item(music_album)
  end

  def add_a_movie
    puts 'Insert publish date (in the format of YYYY/MM/DD)'
    date = gets.chomp
    date = Date.parse(date)
    puts 'Is the movie archived? (y/n)'
    archived = gets.chomp
    archived = %w[Y y].include?(archived)
    puts 'Is the movie silent? (y/n)'
    silent = gets.chomp
    silent = %w[Y y].include?(silent)
    movie = Movie.new(date, archived, silent)
    @movies << movie
  end

  def add_a_game
    raise StandardError, 'not implemented'
  end

  def save
    # Juan
    File.write('./books.json', JSON.dump(@books))
    File.write('./labels.json', JSON.dump(@labels))
    # Saadat

    # Chris

    # Alejandro
  end

  def load
    # Juan
    # rubocop:disable Style/GuardClause
    if File.exist?('./labels.json')
      @labels = JSON.parse(File.read('./labels.json'))
        .map { |data| Label.from_hash(data) }
    end
    if File.exist?('./books.json')
      @books = JSON.parse(File.read('./books.json'))
        .map { |data| Book.from_hash(data, @labels) }
    end
    # rubocop:enable Style/GuardClause
    # Saadat

    # Chris

    # Alejandro
  end
end
