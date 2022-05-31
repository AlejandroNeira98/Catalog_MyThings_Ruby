require './item'
class Book < Item
  def initialize(date, archived, publisher, cover_state, id: nil)
    super(date, archived, id: id)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || (@cover_state == 'bad')
  end
end
