require_relative '../movie'
require 'date'

describe Movie do
  before :all do
    @date1 = Date.new(2001, 0o1, 31)
    @date2 = Date.new(2020, 0o1, 31)
    @movie1 = Movie.new(@date1, false, false)
    @movie2 = Movie.new(@date2, false, true)
    @movie3 = Movie.new(@date2, false, false)
  end

  context 'testing can_be_archived? Movie class method' do
    it 'Should return true when date of publishing is older than 10 years and silent is false' do
      expect(@movie1.can_be_archived?).to be true
    end

    it 'Should return true when silent equals true and date of publishing is more recent than 10 years' do
      expect(@movie2.can_be_archived?).to be true
    end

    it 'Should return false when date of publishing is more recent than 10 years and silent is false' do
      expect(@movie3.can_be_archived?).to be false
    end
  end
end
