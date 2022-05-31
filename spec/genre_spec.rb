require_relative '../models/genre'
require_relative '../models/music_album'
require 'date'

describe Genre do
  before :all do
    @genre = Genre.new('Pop')
  end

  it 'Type of class should be Genre' do
    expect(@genre).to be_a Genre
  end

  it 'Check If Initialized Properly (name = "Pop")' do
    expect(@genre.name).to eq 'Pop'
  end

  it 'Test Add Item Function' do
    music_album = MusicAlbum.new(Date.parse('2003-01-02'), false, false)
    @genre.add_item(music_album)
    expect(@genre.items.length).to be 1
  end

  it 'Should have item of type MusicAlbum at index 0' do
    expect(@genre.items[0]).to be_a MusicAlbum
  end
end
