require_relative '../item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(date, archived, on_spotify, id: nil)
    super(date, archived, id)
    @on_spotify = on_spotify
  end
end
