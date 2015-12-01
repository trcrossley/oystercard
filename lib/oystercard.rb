class Oystercard

  CARD_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE = 1

  attr_reader :balance, :in_use, :entry_station

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "card limit exceeded #{CARD_LIMIT}" if max_limit(amount)
    @balance += amount
  end



  def tap_in(station)
    fail "insufficient funds" if min_limit
    @in_use = true
    @entry_station = station

  end

  def tap_out
    @in_use = false
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_transit?
    !!entry_station
  end


private

  def deduct(amount)
    @balance -= amount
  end

  def max_limit(amount)
    @balance + amount > CARD_LIMIT
  end

  def min_limit
    @balance < MIN_LIMIT
  end

end
