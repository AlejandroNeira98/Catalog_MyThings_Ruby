require_relative './movie'

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
      puts "id: #{movie.id} ,date: #{movie.archived}, silent: #{movie.silent}"
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

  def add_a_movie(date, archived, silent, id: nil)
    movie = Movie.new(date, archived, silent, id: id)
    @movies << movie
  end

  def add_a_game
    raise StandardError, 'not implemented'
  end
end
