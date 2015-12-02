class Oystercard

  CARD_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE = 1

  attr_reader :balance, :in_use, :entry_station, :journeys

  def initialize
    @balance = 0
    @journeys = {}
    @single_journey = []
    @counter = 0
  end

  def top_up(amount)
    fail "card limit exceeded #{CARD_LIMIT}" if max_limit(amount)
    @balance += amount
  end

  def tap_in(entry_station)
    fail "insufficient funds" if min_limit
    @entry_station = entry_station
    tracking_num
    @single_journey << @entry_station
  end

  def tap_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    @single_journey << @exit_station
    journey_log
  end

  def in_transit?
    !!@entry_station
  end


private

  def journey_log
    journeys[@counter] = @single_journey
    @single_journey = []
  end

  def deduct(amount)
    @balance -= amount
  end

  def max_limit(amount)
    @balance + amount > CARD_LIMIT
  end

  def min_limit
    @balance < MIN_LIMIT
  end

  def tracking_num
    @counter += 1
  end

end
