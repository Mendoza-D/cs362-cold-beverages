require_relative '../lib/water_dispenser'
require_relative '../lib/water_reservoir'
require_relative '../lib/vessel'

describe 'A water dispenser' do
  let (:reservoir) { WaterReservoir.new(10) }
  let (:vessel) { Vessel.new('Cup', 5) }
  let (:dispenser) { WaterDispenser.new(reservoir) }

  it 'dispenses water into a vessel' do
    dispenser.dispense(vessel)
    expect(vessel.current_volume).to eq(5)
  end

  it 'reduces the reservoir volume when dispensing' do
    dispenser.dispense(vessel)
    expect(reservoir.current_water_volume).to eq(5)
  end

  it 'dispenses water and fills the vessel without making the reservoir negative' do
    vessel = Vessel.new('Small Cup', 5) # Create a vessel larger than the reservoir
    dispenser.dispense(vessel)
    expect(vessel.current_volume).to eq(5) # Should fill the vessel to the max of the reservoir
    expect(reservoir.current_water_volume).to eq(5) # Reservoir should be empty
end
end

