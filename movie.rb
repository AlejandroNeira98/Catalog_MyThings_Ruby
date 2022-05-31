require_relative './item'

class Movie < Item
  def initialize(silet)
    super
    @silet = silet
  end
end
