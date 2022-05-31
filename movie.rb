require_relative './item'

class Movie < Item
  def initialize(silet)
    super
    @silet = silet
  end

  def can_be_archived?
    super || (@silent == true)
  end
end
