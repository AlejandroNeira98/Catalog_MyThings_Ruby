options_info = ' Type a number to select an option:
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
13) Exit'

OPTIONS = [
  -> { APP.list_all_books },
  -> { APP.list_all_people },
  -> { APP.create_a_person },
  -> { APP.create_a_book },
  -> { APP.create_a_rental },
  -> { APP.list_all_rentals_for_person_id }
].freeze

def main
  loop do
    puts options_info
    choice = gets.to_i
    case choice
    when 1..12
      OPTIONS[option - 1].call
    when 13
      return puts 'Thank you for using this app!'
    end
  end
end

main