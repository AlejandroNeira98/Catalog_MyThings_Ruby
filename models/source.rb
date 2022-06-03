require 'json'
require 'pry'

class Source
  attr_accessor :name
  attr_reader :id, :items

  def initialize(name, id: nil)
    @id = id.nil? ? Time.now.to_i : id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_source(self)
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

  def self.json_creates(object)
    name, id = object['a']
    new(name, id: id)
  end
end
