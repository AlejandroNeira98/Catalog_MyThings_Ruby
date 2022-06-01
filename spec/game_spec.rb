require_relative '.models/movie'
require 'date'

describe Game do
  context 'testing can_be_archived? Game class method' do
    it 'Should return true when date of publishing is older than 10 years and last_played is more than 2 years' do
      @published1 = Date.new(2000, 1, 31)
      @played1 = Date.new(2019, 1, 31)
      @game1 = Game.new(@published1, false, false, @played1)
      expect(@game1.can_be_archived?).to be true
    end

    it 'Should return false when date of publishing is older than 10 years and last_played is less than 2 years' do
      @published2 = Date.new(2000, 1, 31)
      @played2 = Date.new(2021, 1, 31)
      @game2 = Game.new(@published2, false, false, @played2)
      expect(@game2.can_be_archived?).to be false
    end

    it 'Should return false when date of publishing is more recent than 10 years and last_played is more than 2 years' do
      @published3 = Date.new(2015, 1, 31)
      @played3 = Date.new(2018, 1, 31)
      @game3 = Game.new(@published3, false, false, @played3)
      expect(@game3.can_be_archived?).to be false
    end
  end
end
