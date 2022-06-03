require_relative './models/movie'
require 'date'
require 'json'
require './models/game'
require './models/author'
require_relative './controllers/music_album_controller'
require './controllers/book_controller'
require './controllers/label_controller'

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
    @movies = []
    @sources = []
    @games = []
    @authors = []
    @music_album_controller = MusicAlbumController.new
    @book_controller = BookController.new()
    @label_controller = LabelController.new()
    @labels = []
  end

  def add_meta(item)
    label = select_label
    label.add_item(item)
    genre = @music_album_controller.select_genre
    genre.add_item(item)
  end

  def select_label
    @label_controller.select
  end

  def list_all_books
    @book_controller.list
  end

  def list_all_music_albums
    @music_album_controller.list_all_music_albums
  end

  def list_all_movies
    @movies.each_with_index do |movie, index|
      puts ''
      print "#{index + 1} => Released On: #{movie.publish_date}  |*_*|  Silent: #{movie.silent ? 'Yes' : 'No '} |*_*|"
      print "Archived: #{movie.archived ? 'Yes' : 'No '}"
    end
  end

  def list_of_games
    @games.each do |game|
      puts "date: #{game.publish_date}, multiplayer: #{game.multiplayer}, last played: #{game.last_played_at}"
    end
  end

  def list_all_genres
    @music_album_controller.list_all_genres
  end

  def list_all_labels
    @label_controller.list
  end

  def list_all_authors
    @authors.each do |author|
      puts "#{author.first_name} #{author.last_name}"
    end
  end

  def list_all_sources
    @sources.each do |source|
      puts source.name.to_s
    end
  end

  def add_a_book
    book = @book_controller.add
    add_meta(book)
  end

  def add_a_music_album
    @music_album_controller.add_a_music_album
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
    puts 'Insert publish date (in the format of YYYY/MM/DD)'
    published = gets.chomp
    published = Date.parse(published)
    puts 'Is the game archived? (y/n)'
    archived = gets.chomp
    archived = %w[Y y].include?(archived)
    puts 'Is the game multiplayer? (y/n)'
    multiplayer = gets.chomp
    multiplayer = %w[Y y].include?(multiplayer)
    puts 'Insert date you last played (in the format of YYYY/MM/DD)'
    last_played = gets.chomp
    last_played = Date.parse(last_played)
    a_game = Game.new(published, archived, multiplayer, last_played)
    @games << a_game
  end

  def save
    Dir.mkdir('./data/') unless File.directory?('./data/')
    File.write('./data/books.json', JSON.dump(@book_controller.books))
    File.write('./data/labels.json', JSON.dump(@label_controller.labels))
    # Saadat
    File.open('./data/music_album.json', 'w') do |file|
      JSON.dump(@music_album_controller.music_albums, file)
    end
    File.open('./data/genre.json', 'w') do |file|
      JSON.dump(@music_album_controller.genres, file)
    end
    # Chris
    File.write('./data/games.json', JSON.dump(@games)) unless @games.empty?
    File.write('./data/authors.json', JSON.dump(@authors)) unless @authors.empty?
    # Alejandro
    File.open('./data/movies.json', 'w') do |file|
      JSON.dump(@movies, file)
    end
    File.open('./data/source.json', 'w') do |file|
      JSON.dump(@source, file)
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def load
    Dir.mkdir('./data/') unless File.directory?('./data/')
    # rubocop:disable Style/GuardClause
    if File.exist?('./data/labels.json')
      @label_controller.labels = JSON.parse(File.read('./data/labels.json'))
        .map { |data| Label.from_hash(data) }
    end
    if File.exist?('./data/books.json')
      @book_controller.books = JSON.parse(File.read('./data/books.json'))
        .map { |data| Book.from_hash(data, @label_controller.labels) }
    end
    # Saadat
    @music_album_controller.genres = load_genre
    @music_album_controller.music_albums = load_music_album

    # Chris
    load_game_author
    # Alejandro
    if File.exist?('./data/movies.json')
      @movies = JSON.parse(File.read('./data/movies.json'))
        .map { |data| Movie.json_creates(data) }
    end
    if File.exist?('./data/sources.json')
      @sources = JSON.parse(File.read('./data/sources.json'))
        .map { |data| Source.json_creates(data) }
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

  def load_game_author
    if File.exist?('./data/authors.json')
      @authors = JSON.parse(File.read('./data/authors.json'))
        .map { |data| Author.from_hash(data) }
    end
    if File.exist?('./data/games.json')
      @games = JSON.parse(File.read('./data/games.json'))
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
