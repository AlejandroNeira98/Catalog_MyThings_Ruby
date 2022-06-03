require_relative '../models/movie'

class MoviesController
  attr_accessor :movies

  def initialize
    @movies = []
  end

  def list_all_movies
    @movies.each_with_index do |movie, index|
      puts ''
      print "#{index + 1} => Released On: #{movie.publish_date}  |*_*|  Silent: #{movie.silent ? 'Yes' : 'No '} |*_*|"
      print "Archived: #{movie.archived ? 'Yes' : 'No '}"
      # print "|*_*| Genre: #{movie.genre.name}"
      # print "|*_*| Author: #{movie.author.first_name} #{movie.author.last_name}"
      print "|*_*| Label: #{movie.label.title}"
      print "|*_*| Source: #{movie.source.name}"
    end
  end

  def create_a_movie
    puts 'Insert publish date (in the format of YYYY/MM/DD)'
    date = gets.chomp
    date = Date.parse(date)
    puts 'Is the movie archived? (y/n)'
    archived = gets.chomp
    archived = %w[Y y].include?(archived)
    puts 'Is the movie silent? (y/n)'
    silent = gets.chomp
    silent = %w[Y y].include?(silent)
    Movie.new(date, archived, silent)
  end

  def save_movies
    File.open('./data/movies.json', 'w') do |file|
      JSON.dump(@movies, file)
    end
  end

  def load_movies(labels, sources, genres)
    return unless File.exist?('./data/movies.json')

    @movies = JSON.parse(File.read('./data/movies.json'))
      .map { |data| Movie.json_creates(data, labels, sources, genres) }
  end
end
