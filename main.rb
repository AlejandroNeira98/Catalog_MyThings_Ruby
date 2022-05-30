require './app'
APP = App.new
OPTIONS_INFO = ' Type a number to select an option:
1) List all books
2) List all music albums
3) List all movies
4) List of games
5) List all genres
6) List all labels
7) List all authors
8) List all sources
9) Add a book
10) Add a music album
11) Add a movie
12) Add a game
13) Exit'.freeze

OPTIONS = [
  -> { APP.list_all_books },
  -> { APP.list_all_music_albums },
  -> { APP.list_all_movies },
  -> { APP.list_of_games },
  -> { APP.list_all_genres },
  -> { APP.list_all_labels },
  -> { APP.list_all_authors },
  -> { APP.list_all_sources },
  -> { APP.add_a_book },
  -> { APP.add_a_music_album },
  -> { APP.add_a_movie },
  -> { APP.add_a_game }
].freeze

def main
  loop do
    puts OPTIONS_INFO
    choice = gets.to_i
    case choice
    when 1..12
      OPTIONS[choice - 1].call
    when 13
      return puts 'Thank you for using this app!'
    end
  end
end

main
