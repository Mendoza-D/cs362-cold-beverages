require_relative '../lib/freezer'
require_relative '../lib/item'

describe 'A freezer' do
  let (:freezer) { Freezer.new(100) } # Create a freezer with a capacity of 100
  let (:item) { Item.new('Ice Cream', 20) } # Create an item with a volume of 20

  it 'starts powered off' do
    expect(freezer.instance_variable_get(:@power)).to eq(:off)
  end

  it 'can be powered on' do
    freezer.turn_on
    expect(freezer.instance_variable_get(:@power)).to eq(:on)
  end

  it 'can be powered off' do
    freezer.turn_on # First turn it on
    freezer.turn_off
    expect(freezer.instance_variable_get(:@power)).to eq(:off)
  end

  it 'adds an item to the freezer when powered on' do
    freezer.turn_on
    freezer.add(item)
    expect(freezer.contents).to include(item)
  end

  it 'calculates remaining capacity correctly' do
    freezer.add(item)
    expect(freezer.remaining_capacity).to eq(80) # 100 - 20 (item volume)
  end

  it 'sets temperature leve' do
    freezer.set_level(3) #Level 3 should reduce temp by 30 degrees
    expect(freezer.temperature).to eq(40) # 70 - (3 * 10) = 40
  end
end
