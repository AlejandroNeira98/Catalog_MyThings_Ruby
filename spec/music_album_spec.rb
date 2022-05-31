require_relative '../models/music_album'
require 'date'

describe MusicAlbum do
  before :all do
    @music_album = MusicAlbum.new(Date.parse('2003-01-02'), false, false)
  end

  it 'Should Be Class of Type Music Album' do
    expect(@music_album).to be_a MusicAlbum
  end

  it 'Should Inherit From Item Class' do
    expect(@music_album).to be_a Item
  end

  it 'Can not be Archived' do
    expect(@music_album.can_be_archived?).to be false
  end
end
