class Source
  def initialize(name, id: nill)
    @id = id.nil? ? Time.now.to_i : id
    @name = name
    @items = []
  end
end
