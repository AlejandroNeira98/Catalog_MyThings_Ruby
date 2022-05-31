class Author
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name, id: nil)
    @id id.nil? ? Time.now.to_i : id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_author(self)
  end
end