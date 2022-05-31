class Source
  attr_accessor :items, :name

  def initialize(name, id: nil)
    @id = id.nil? ? Time.now.to_i : id
    @name = name
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_source(self)
  end
end
