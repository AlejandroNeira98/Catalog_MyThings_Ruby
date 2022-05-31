require_relative '../item'

class Genre
  attr_writer :items

  def initialize(name, id: nil)
    @id = id.nil? ? Time.now.to_i : id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_genre(self)
  end
end
