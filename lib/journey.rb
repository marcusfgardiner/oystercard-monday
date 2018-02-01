class Journey
  attr_accessor :entry_station, :exit_station

  def initialize
  end

  def start_journey(station)
    @entry_station = station
  end

  def finish_journey(station, oystercard)
    @exit_station = station
    oystercard.store_journey_history
    oystercard.deduct(fare)
  end

  def fare
    (@entry_station == nil || @exit_station == nil) ? 6 : 1
  end
end
