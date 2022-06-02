require_relative '../models/music_album'
require_relative '../models/genre'

class MusicAlbumController
  def initialize
    @music_albums = []
    @genres = []
  end

  def colorize(foreground_color, text)
    "\e[#{foreground_color}m#{text}\e[0m"
  end

  def released_on_menu_text(album, index)
    print colorize(COLOR_CODES['pink'], (index + 1).to_s).to_s
    print " => #{colorize(COLOR_CODES['cyan'], 'Released On:')} #{album.publish_date}  "
  end

  def archived_menu_text(album)
    print colorize(COLOR_CODES['yellow'], '|*_*|').to_s
    print "  #{colorize(COLOR_CODES['cyan'], 'Archived:')} "
    print album.archived ? colorize(COLOR_CODES['green'], 'Yes').to_s : colorize(COLOR_CODES['red'], 'No ').to_s
  end

  def on_spotify_text(album)
    print "  #{colorize(COLOR_CODES['yellow'], '|*_*|')}  #{colorize(COLOR_CODES['cyan'], 'On Spotify:')} "
    print album.on_spotify ? colorize(COLOR_CODES['green'], 'Yes').to_s : colorize(COLOR_CODES['red'], 'No ').to_s
  end

  def genre_text(album)
    print colorize(COLOR_CODES['yellow'], '  |*_*|').to_s
    print "  #{colorize(COLOR_CODES['cyan'], 'Genre')}: #{album.genre.name}"
  end

  def list_all_music_albums
    @music_albums.each_with_index do |album, index|
      puts ''
      released_on_menu_text(album, index)
      archived_menu_text(album)
      on_spotify_text(album)
      genre_text(album)
      puts ''
    end
  end

  def list_all_genres
    @genres.each_with_index do |genre, index|
      puts "#{index + 1} => #{colorize(COLOR_CODES['cayan'], genre.name)}"
    end
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
end
