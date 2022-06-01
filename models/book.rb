require './item'
class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(date, archived, publisher, cover_state, id: nil)
    super(date, archived, id: id)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || (@cover_state == 'bad')
  end
end
