class Journey
  attr_accessor :entry_station

  def initialize
    @in_journey = false
  end

  def in_journey?
    !!entry_station
  end

  def start_journey(station)
    @entry_station = station
    @in_journey = true
  end
end
