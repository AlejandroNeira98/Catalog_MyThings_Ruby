class Author
  attr_accessor :first_name, :last_name
  attr_reader :id, :items

  def initialize(first_name, last_name, id: nil)
    @id = id.nil? ? Time.now.to_i : id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_author(self)
  end

  def to_json(*_args)
    { first_name: first_name, last_name: last_name, id: id }.to_json
  end

  def self.from_hash(hash)
    first_name, last_name, id = *hash
    new(first_name[1], last_name[1], id: id[1])
  end
end
