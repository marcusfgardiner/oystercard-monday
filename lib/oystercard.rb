require_relative 'station'

class Oystercard

  BALANCE_LIMIT = 90
  BALANCE_MIN = 1
  MIN_CHARGE = 3

  attr_reader :balance, :entry_station, :exit_station, :journey_history

  def initialize(balance = 0, in_journey = nil)
    @balance = balance
    @in_journey = in_journey
    @journey_history = []
  end

  def in_journey?
    @in_journey == true
  end

  def touch_in(station)
    pre_touch_in_checks
    @in_journey = true
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    @in_journey = false
    @exit_station = station
    store_journey_history
  end

  def top_up(amount)
    pre_top_up_checks(amount)
    @balance += amount
  end

  def store_journey_history
    @journey_history << {"Entry Station: " => @entry_station, "Exit Station: " => @exit_station}
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def pre_top_up_checks(amount)
    fail "Error - maximum balance is #{BALANCE_LIMIT} pounds" if (@balance + amount > BALANCE_LIMIT)
  end

  def pre_touch_in_checks
    fail "Insufficient funds - minimum balance is #{BALANCE_MIN}" if @balance < BALANCE_MIN
  end

end
