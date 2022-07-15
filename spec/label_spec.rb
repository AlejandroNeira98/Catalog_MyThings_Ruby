require './models/label'
require './item'

describe Label do
  before :all do
    @label = Label.new('New', 'green')
  end
  context 'add_item method' do
    before :all do
      @item = Item.new(Time.now, true)
    end

    it 'should take an instance of the Item class as an input' do
      result = @label.method(:add_item).arity

      expect(result).to eq(1)
    end

    it 'should add the input item to the collection of items' do
      @label.add_item(@item)

      expect(@label.items[0]).to be(@item)
    end

    it 'should add self as a property of the item object (by using the correct setter from the item object)' do
      @label.add_item(@item)

      expect(@item.label).to be(@label)
    end
  end
end
