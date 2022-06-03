require_relative './models/movie'
require 'date'
require 'json'
require './models/game'
require './models/author'
require './models/source'
require_relative './controllers/music_album_controller'
require_relative './controllers/game_controller'
require_relative './controllers/game_controller'
require_relative './controllers/movies_controller'
require_relative './controllers/sources_controller'
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

# rubocop:disable Metrics/ClassLength
class App
  def initialize
    @game_controller = GameController.new
    @movies_controller = MoviesController.new
    @sources_controller = SourcesController.new
    @music_album_controller = MusicAlbumController.new
    @books = []
    @labels = []
  end

  def add_meta(item)
    label = select_label
    label.add_item(item)
    genre = @music_album_controller.select_genre
    genre.add_item(item)
    source = @sources_controller.select_source
    source.add_item(item)
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
      puts 'Title:'
      title = gets.chomp
      puts 'Color(black/red/green/yellow/blue/pink/cyan/white/default):'
      color = gets.chomp
      color = 'default' if COLOR_CODES[color].nil?
      label = Label.new(title, color)
    end
    @labels << label
    label
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

  def list_all_music_albums
    @music_album_controller.list_all_music_albums
  end

  def list_all_movies
    @movies_controller.list_all_movies
  end

  def list_of_games
    @game_controller.list_of_games
  end

  def list_all_genres
    @music_album_controller.list_all_genres
  end

  def list_all_labels
    formated = @labels.map do |label|
      "\033[#{COLOR_CODES[label.color]}m#{label.title}\033[0m"
    end
    puts formated.join(', ')
  end

  def list_all_authors
    @game_controller.list_all_authors
  end

  def list_all_sources
    @sources_controller.list_all_sources
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
    add_meta(book)
  end

  def add_a_music_album
    @music_album_controller.add_a_music_album
  end

  def add_a_movie
    movie = @movies_controller.create_a_movie
    add_meta(movie)
    @movies_controller.movies << movie
  end

  def add_a_game
    @game_controller.add_a_game
  end

  def save
    Dir.mkdir('./data/') unless File.directory?('./data/')
    # Juan
    File.write('./data/books.json', JSON.dump(@books))
    File.write('./data/labels.json', JSON.dump(@labels))
    # Saadat
    File.open('./data/music_album.json', 'w') do |file|
      JSON.dump(@music_album_controller.music_albums, file)
    end
    File.open('./data/genre.json', 'w') do |file|
      JSON.dump(@music_album_controller.genres, file)
    end
    # Chris
    File.write('./data/games.json', JSON.dump(@game_controller.games)) unless @game_controller.games.empty?
    File.write('./data/authors.json', JSON.dump(@game_controller.authors)) unless @game_controller.authors.empty?
    # Alejandro
    @movies_controller.save_movies
    @sources_controller.save_sources
  end

  def load
    Dir.mkdir('./data/') unless File.directory?('./data/')
    # Juan
    # rubocop:disable Style/GuardClause
    if File.exist?('./data/labels.json')
      @labels = JSON.parse(File.read('./data/labels.json'))
        .map { |data| Label.from_hash(data) }
    end
    if File.exist?('./data/books.json')
      @books = JSON.parse(File.read('./data/books.json'))
        .map { |data| Book.from_hash(data, @labels) }
    end
    # Saadat
    @music_album_controller.genres = load_genre
    @music_album_controller.music_albums = load_music_album

    # Chris
    load_game_author
    # Alejandro
    @sources_controller.load_sources
    @movies_controller.load_movies(@labels, @sources_controller.sources, @music_album_controller.genres)
  end

  def load_game_author
    if File.exist?('./data/authors.json')
      @game_controller.authors = JSON.parse(File.read('./data/authors.json'))
        .map { |data| Author.from_hash(data) }
    end
    if File.exist?('./data/games.json')
      @game_controller.games = JSON.parse(File.read('./data/games.json'))
        .map { |data| Game.from_hash(data) }
    end
    # rubocop:enable Style/GuardClause
  end

  def load_music_album
    return [] unless File.exist?('./data/music_album.json')

    JSON.parse(File.read('./data/music_album.json'))
      .map { |data| MusicAlbum.json_create(data, @music_album_controller.genres) }
  end

  def load_genre
    return [] unless File.exist?('./data/genre.json')

    JSON.parse(File.read('./data/genre.json'))
      .map { |data| Genre.json_create(data) }
  end
end
# rubocop:enable Metrics/ClassLength
