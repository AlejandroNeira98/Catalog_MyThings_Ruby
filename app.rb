require_relative './models/movie'
require 'date'
require 'json'
require './models/game'
require './models/author'
require './models/source'
require_relative './controllers/music_album_controller'
require_relative './controllers/game_controller'
require_relative './controllers/movies_controller'
require_relative './controllers/sources_controller'
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

class App
  def initialize
    @game_controller = GameController.new
    @movies_controller = MoviesController.new
    @sources_controller = SourcesController.new
    @music_album_controller = MusicAlbumController.new
    @book_controller = BookController.new
    @label_controller = LabelController.new
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
    @label_controller.select
  end

  def list_all_books
    @book_controller.list
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
    @label_controller.list
  end

  def list_all_authors
    @game_controller.list_all_authors
  end

  def list_all_sources
    @sources_controller.list_all_sources
  end

  def add_a_book
    book = @book_controller.add
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
    File.write('./data/books.json', JSON.dump(@books))
    File.write('./data/labels.json', JSON.dump(@label_controller.labels))
    File.open('./data/music_album.json', 'w') do |file|
      JSON.dump(@music_album_controller.music_albums, file)
    end
    File.open('./data/genre.json', 'w') do |file|
      JSON.dump(@music_album_controller.genres, file)
    end
    File.write('./data/games.json', JSON.dump(@game_controller.games)) unless @game_controller.games.empty?
    File.write('./data/authors.json', JSON.dump(@game_controller.authors)) unless @game_controller.authors.empty?
    @movies_controller.save_movies
    @sources_controller.save_sources
  end

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
    @music_album_controller.genres = load_genre
    @music_album_controller.music_albums = load_music_album
    load_game_author
    @sources_controller.load_sources
    @movies_controller.load_movies(@label_controller.labels, @sources_controller.sources, @music_album_controller.genres)
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
