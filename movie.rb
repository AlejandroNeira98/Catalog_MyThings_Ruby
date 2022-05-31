require_relative './item'

class Movie < Item
  def initialize(date, archived, silent, id: nil)
    super(date, archived, id)
    @silent = silent
  end

  def can_be_archived?
    super || (@silent == true)
  end
end
