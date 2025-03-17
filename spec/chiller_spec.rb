require_relative '../lib/chiller'
require_relative '../lib/item'

describe 'A chiller' do
  let (:chiller) { Chiller.new(100) } # Create a chiller with a capacity of 100
  let (:item) { Item.new('Soda', 20) } # Create an item with a volume of 20

  it 'starts powered off' do
    expect(chiller.instance_variable_get(:@power)).to eq(:off)
  end

  it 'can be powered on' do
    chiller.turn_on
    expect(chiller.instance_variable_get(:@power)).to eq(:on)
  end

  it 'can be powered off' do
    chiller.turn_on # First turn it on
    chiller.turn_off
    expect(chiller.instance_variable_get(:@power)).to eq(:off)
  end

  it 'adds an item to the chiller when powered on' do
    chiller.turn_on
    chiller.add(item)
    expect(chiller.contents).to include(item)
  end

  it 'calculates remaining capacity correctly' do
    chiller.add(item)
    expect(chiller.remaining_capacity).to eq(80) # 100 - 20 (item volume)
  end

  it 'sets temperature level' do
    chiller.set_level(3) # Level 3 should reduce temp by 30 degrees
    expect(chiller.temperature).to eq(55) # 70 - 15 = 55
  end

end
