require_relative './movie'
require 'date'

class App
  def initialize
    @movies = []
    @sources = []
  end

  def list_all_books
    raise StandardError, 'not implemented'
  end

  def list_all_music_albums
    raise StandardError, 'not implemented'
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
    raise StandardError, 'not implemented'
  end

  def list_all_labels
    raise StandardError, 'not implemented'
  end

  def list_all_authors
    raise StandardError, 'not implemented'
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
    raise StandardError, 'not implemented'
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
end
