class Label
  attr_accessor :title, :color
  attr_reader :id, :items

  def initialize(title, color, id: nil)
    @id = id.nil? ? Time.now.to_i : id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_label(self)
  end
end
