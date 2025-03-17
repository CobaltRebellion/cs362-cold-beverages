require_relative '../lib/item'

describe 'An item of food or a beverage' do
    it 'has a name and volume' do
        item = Item.new("FAKE", 200)
        expect(item.name).to eq('FAKE')
        expect(item.volume).to eq(200)

    end
end
