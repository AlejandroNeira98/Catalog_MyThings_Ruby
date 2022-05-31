require_relative '../source'
require_relative '../item'

describe Source do
  context 'Testing Source class add_source method' do
    before :all do
      @source = Source.new('Some name')
      @item = Item.new('date', true)
      @source.add_item(@item)
    end
    it 'should add the item to items property in source' do
      expect(@source.items).to include(@item)
    end

    it 'should create source intance in item' do
      expect(@item.source).to be @source
    end
  end
end
