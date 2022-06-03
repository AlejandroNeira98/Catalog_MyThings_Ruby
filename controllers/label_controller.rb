require './models/label'

class LabelController
    attr_accessor :labels
    def initialize
      @labels = []
    end

    def select
      puts "  \t|id\t\t|title\t\t|color\n#{['-'] * 50 * ''}"
      @labels.each_with_index do |label, i|
        puts "#{i})\t#{label.id}\t#{label.title}\t\t\033[#{COLOR_CODES[label.color]}m#{label.color}\033[0m"
      end
      puts "#{@labels.length})\t+ Add label"
      puts 'Select a label:'
      label = @labels[gets.to_i]
      if label.nil?
        puts 'Tile:'
        title = gets.chomp
        puts 'Color(black/red/green/yellow/blue/pink/cyan/white/default):'
        color = gets.chomp
        color = 'default' if COLOR_CODES[color].nil?
        label = Label.new(title, color)
        @labels << label
      end

      label
    end
  
    def list
      formated = @labels.map do |label|
        "\033[#{COLOR_CODES[label.color]}m#{label.title}\033[0m"
      end
      puts formated.join(', ')
    end
  end
  