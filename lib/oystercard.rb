require_relative 'station'
require_relative 'journey'

class Oystercard

  BALANCE_LIMIT = 90
  BALANCE_MIN = 1

  attr_reader :balance, :journey_history, :current_journey

  def initialize(balance = 0)
    @balance = balance
    @journey_history = []
  end

  def touch_in(station)
    pre_touch_in_checks
    @current_journey = Journey.new
    @current_journey.start_journey(station)
  end

  def touch_out(station)
    @current_journey = Journey.new if @current_journey == nil
    @current_journey.finish_journey(station, self)
    @current_journey = nil
  end

  def top_up(amount)
    pre_top_up_checks(amount)
    @balance += amount
  end

  def store_journey_history(entry_station, exit_station)
    @journey_history << {"Entry Station: " => entry_station, "Exit Station: " => exit_station}
  end

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
