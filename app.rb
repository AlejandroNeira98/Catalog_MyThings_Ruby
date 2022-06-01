
require_relative './movie'
require 'date'
require_relative './models/music_album'
require './models/game'
require './models/author'

class App
  def initialize
    @movies = []
    @sources = []
    @music_albums = []
    @games = []
    @authors []
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
    @movies.each do |movie|
      puts "date: #{movie.can_be_archived?}, silent: #{movie.silent}"
    end
  end

  def list_of_games
    @games.each do |game|
      puts "date: #{game.date}, multiplayer: #{game.multiplayer}, last played: #{game.last_played_at}"
    end
  end

  def list_all_genres
    raise StandardError, 'not implemented'
  end

  def list_all_labels
    raise StandardError, 'not implemented'
  end

  def list_all_authors
    @authors.each do |author|
      puts "#{author.first_name} #{author.last_name}"
  end

  def list_all_sources
    @sources.each do |source|
      puts source.name.to_s
    end
  end

  def add_a_book
    raise StandardError, 'not implemented'
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
    published = Date.parse(date)
    puts 'Is the game archived? (y/n)'
    archived = gets.chomp
    archived = %w[Y y].include?(archived)
    puts 'Is the game multiplayer? (y/n)'
    multiplayer = gets.chomp
    multiplayer = %w[Y y].include?(silent)
    puts 'Insert date you last played (in the format of YYYY/MM/DD)'
    last_played = gets.chomp
    last_played = Date.parse(date)
    game = Game.new(date, archived, multiplayer, last_played)
    @movies << movie
  end
end
