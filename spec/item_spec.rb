require_relative '../lib/item'

describe 'An item of food or a beverage' do
  it 'has a name and volume' do
    item = Item.new('Milk', 50)
    expect(item.name).to eq ('Milk')
    expect(item.volume).to eq(50)
  end
end
