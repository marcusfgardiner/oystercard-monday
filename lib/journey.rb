class Journey
  attr_accessor :entry_station, :exit_station

  def initialize
  end

  def in_journey?
    !!entry_station
  end

  def start_journey(station)
    @entry_station = station
  end

  def finish_journey(station, oystercard)
    @exit_station = station
    oystercard.store_journey_history(@entry_station, @exit_station)
    @entry_station = nil
  end
end
