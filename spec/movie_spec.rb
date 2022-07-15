require_relative '../models/movie'
require 'date'

describe Movie do
  context 'testing can_be_archived? Movie class method' do
    before :all do
      @date2 = Date.new(2020, 1, 31)
    end

    it 'Should return true when date of publishing is older than 10 years and silent is false' do
      @date1 = Date.new(2001, 0o1, 31)
      @movie1 = Movie.new(@date1, false, false)
      expect(@movie1.can_be_archived?).to be true
    end

    it 'Should return true when silent equals true and date of publishing is more recent than 10 years' do
      @movie2 = Movie.new(@date2, false, true)
      expect(@movie2.can_be_archived?).to be true
    end

    it 'Should return false when date of publishing is more recent than 10 years and silent is false' do
      @movie3 = Movie.new(@date2, false, false)
      expect(@movie3.can_be_archived?).to be false
    end
  end
end
