require_relative '../models/source'

class SourcesController
  attr_accessor :sources

  def initialize
    @sources = []
  end

  def list_all_sources
    @sources.each_with_index do |source, index|
      puts "#{index + 1} => #{source.name}"
    end
  end

  def select_source
    puts 'What is the source? (press 0 for creating source)'
    puts 'No source Created Yet' if @sources.length.zero?
    list_all_sources
    loop do
      opt = gets.chomp.to_i
      if opt.zero?
        print 'Name of source: '
        name = gets.chomp
        new_source = Source.new(name)
        @sources << new_source
        puts "#{@sources.length} => #{new_source.name}"
      else
        result_source = @sources[opt - 1]
        return result_source unless result_source.nil?

        puts 'Not Found!'
      end
    end
  end

  def save_sources
    File.open('./data/sources.json', 'w') do |file|
      JSON.dump(@sources, file)
    end
  end

  def load_sources
    return unless File.exist?('./data/sources.json')

    @sources = JSON.parse(File.read('./data/sources.json'))
      .map { |data| Source.json_creates(data) }
  end
end
