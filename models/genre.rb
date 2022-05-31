require_relative '../item'

class Genre
  attr_writer :items

  def initialize(name, id: nil)
    @id = id.nil? ? Time.now.to_i : id
    @name = name
    @items = []
  end
end
