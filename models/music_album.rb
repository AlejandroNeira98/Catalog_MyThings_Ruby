require_relative '../item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(date, archived, on_spotify, id: nil)
    super(date, archived, id: id)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end
end
