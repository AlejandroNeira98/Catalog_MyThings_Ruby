require './models/book'

describe Book do
  context 'can_be_archived? method' do
    it 'should override the method from the parent class' do
      method = Book.method(:can_be_archived?)

      owner = method.owner

      expect(owner).to be(Book)
    end

    it 'should return true if parent\'s method returns true OR if cover_state equals to "bad"' do
      book_older_than_10_years = Book.new(Time.new(Time.now.year - 10), true, 'McGraw Hill', 'good')
      new_book = Book.new(Time.now, true, 'McGraw Hill', 'bad')

      result1 = new_book.can_be_archived?
      result2 = book_older_than_10_years.can_be_archived?

      expect(result1).to be(true)
      expect(result2).to be(true)
    end

    it 'otherwise, it should return false' do
      new_book = Book.new(Time.now, true, 'McGraw Hill', 'good')

      result = new_book.can_be_archived?

      expect(result).to be(false)
    end
  end
end
