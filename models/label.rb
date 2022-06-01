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

  def to_json(*_args)
    { title: title, color: color, id: id }.to_json
  end

  def self.from_hash(hash)
    title, color, id = *hash

    new(title, color, id: id)
  end
end
