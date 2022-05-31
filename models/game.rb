require ',/item'

class Game < item
  attr_accessor :multiplayer :last_played_at
  def initialize(date, archived, multiplayer, last_played_at, id: nil)
    super(date, archived, id: id)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
end
