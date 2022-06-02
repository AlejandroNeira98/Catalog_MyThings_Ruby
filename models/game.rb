require './item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(date, archived, multiplayer, last_played_at, id: nil)
    super(date, archived, id: id)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    current_time = Time.new
    super && current_time.year - @last_played_at.year > 2
  end

  def to_json(*_args)
    { publish_date: @publish_date, archived: @archived, multiplayer: @multiplayer,
      last_played_at: @last_played_at, id: @id }.to_json
  end

  def self.from_hash(hash)
    publish_date, archived, multiplayer, last_played_at, id = *hash
    new(publish_date, archived, multiplayer, last_played_at, id: id)
  end
end
