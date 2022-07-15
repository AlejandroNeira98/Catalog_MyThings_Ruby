require_relative '../item'

class Genre
  attr_accessor :name, :items
  attr_reader :id

  def initialize(name, id: nil)
    @id = id.nil? ? Time.now.to_i : id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_genre(self)
  end

  def as_json()
    {
      JSON.create_id => self.class.name,
      'a' => [@name, @id]
    }
  end

  def to_json(*options)
    as_json.to_json(*options)
  end

  def self.json_create(object)
    name, id = object['a']
    new(name, id: id)
  end
end
