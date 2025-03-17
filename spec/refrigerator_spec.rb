require_relative '../lib/refrigerator'
require_relative '../lib/item'
require_relative '../lib/freezer'
require_relative '../lib/water_dispenser'
require_relative '../lib/water_reservoir'
require_relative '../lib/chiller'


describe Refrigerator do
  let(:chiller) { Chiller.new(150) } # Create a chiller with a capacity of 150
  let(:freezer) { Freezer.new(100) } # Create a freezer with a capacity of 100
  let (:water_reservoir) { WaterReservoir.new(50,50) } # Create a water reservoir with a capacity of 50
  let(:water_dispenser) { WaterDispenser.new(water_reservoir) } # Create a water dispenser with the reservoir
  let(:fridge) { Refrigerator.new(chiller, freezer, water_dispenser, water_reservoir) } # Create a refrigerator with the chiller, freezer, and water dispenser
  let(:item) { Item.new('Milk', 20) } # Create an item with a volume of 20

  it 'starts powered off' do
    expect(fridge.instance_variable_get(:@power)).to eq(:off)
  end

  it 'can be powered on' do
    fridge.plug_in
    expect(fridge.instance_variable_get(:@power)).to eq(:on)
  end

  it 'can be powered off' do
    fridge.plug_in # First turn it on
    fridge.unplug
    expect(fridge.instance_variable_get(:@power)).to eq(:off)
  end

  it 'adds an item to the chiller' do
    fridge.chill(item)
    expect(fridge.chiller.contents).to include(item)
  end

  it 'adds an item to the freezer' do
    fridge.freeze(item)
    expect(fridge.freezer.contents).to include(item)
  end

  it 'calculates total capcity correctly' do
    expect(fridge.total_capacity).to eq(250) # 150 (chiller) + 100 (freezer)
  end

  it 'calculates remaining capacity correctly' do
    fridge.chill(item) #Adding 20 volume to chiller
    fridge.freeze(item)# Adding 20 volume to freezer
    expect(fridge.remaining_capacity).to eq(210) # 250 - 20 (chiller) - 20 (freezer)
  end

  it 'sets chiller temperature level' do
    fridge.set_chiller_level(2) # Level 2 should reduce temp by 10
    expect(fridge.chiller.temperature).to eq(60) # 70 - (2 * 5) = 60
  end

  it 'sets freezer temperature level' do
    fridge.set_freezer_level(3) # Level 3 should reduce temp by 30
    expect(fridge.freezer.temperature).to eq(40) # 70 - (3 * 10) = 40
  end

  it 'outputs a string representation of its status' do
    fridge.plug_in # Power on the refrigerator
    status = fridge.to_s
    expect(status).to include("Power: on")
    expect(status).to include("Storage: #{fridge.remaining_capacity} of #{fridge.total_capacity} available")
    expect(status).to include("Temps: Chiller is #{fridge.chiller.temperature}, Freezer is #{fridge.freezer.temperature}")
    expect(status).to include("Water: Reservoir has #{fridge.water_reservoir.current_water_volume} remaining")
  end
end


