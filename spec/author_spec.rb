require_relative './models/author'
require_relative './item'

describe Author do
  context 'Testing Author class add_item method' do
    before :all do
      @author = Author.new('J.R.R. Tolkien')
      @item = Item.new('date', true)
      @author.add_item(@item)
    end
    it 'should add the item to items property in author' do
      expect(@author.items).to include(@item)
    end

    it 'should create author instance in item' do
      expect(@item.author).to be @author
    end
  end
end
