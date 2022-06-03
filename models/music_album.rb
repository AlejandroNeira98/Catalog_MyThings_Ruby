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

  def as_json()
    {
      JSON.create_id => self.class.name,
      'a' => [@publish_date, @archived, @on_spotify, @id, @genre.id]
    }
  end

  def to_json(*options)
    as_json.to_json(*options)
  end

  def self.json_create(object, genres)
    date, archived, on_spotify, id, genre_id = object['a']
    music_album_instance = new(date, archived, on_spotify, id: id)
    genres.each do |genre|
      genre.add_item(music_album_instance) if genre.id == genre_id
    end
    music_album_instance
  end
end
