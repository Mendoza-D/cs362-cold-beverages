class Vessel
  attr_reader :name, :volume, :current_volume

  def initialize(name='FAKE', volume= 100)
    @name = name
    @volume = volume
    @current_volume = 0 # start with an empty vessel
  end


  def empty?
    @current_volume == 0
  end

  def fill(amount = nil)
    amount ||= @volume # set to max if no amount is specified
    @current_volume = [@current_volume + amount, @volume].min # fill the vessel to its maximum capacity
  end
end
