class WaterDispenser

  def initialize(reservoir)
    @reservoir = reservoir
  end

  def dispense(vessel)
    return if @reservoir.remaining <= 0 #dont dispense if there isnt water left

    amount_to_dispense = [vessel.volume, @reservoir.remaining].min # dispense only what the vessel can hold or what is available in the reservoir
    vessel.fill(amount_to_dispense)
    @reservoir.drain(amount_to_dispense)
  end
end
