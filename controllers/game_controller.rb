class GameController
  attr_accessor :games, :authors

  def initialize
    @games = []
    @authors = []
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

  def list_of_games
    @games.each do |game|
      puts "date: #{game.publish_date}, multiplayer: #{game.multiplayer}, last played: #{game.last_played_at}"
    end
  end

  def list_all_authors
    @authors.each do |author|
      puts "#{author.first_name} #{author.last_name}"
    end
  end
end
