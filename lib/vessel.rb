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

  def fill
    @current_volume = @volume # assume filling it means it gets filled to full capacity
  end
end
