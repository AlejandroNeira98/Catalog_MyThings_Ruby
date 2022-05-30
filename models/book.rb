require './item'
class Book < Item
  def initialize(date, archived, publisher, cover_state, id: nil)
    super(date, archived, id: id)
    @publisher = publisher
    @cover_state = cover_state
  end
end
