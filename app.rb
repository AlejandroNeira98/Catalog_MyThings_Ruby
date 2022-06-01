require 'date'
require_relative './models/music_album'
require '.models/game'

class App
  def initialize
    @music_albums = []
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
    raise StandardError, 'not implemented'
  end

  def add_a_game
    raise StandardError, 'not implemented'
  end
end
