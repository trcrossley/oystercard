class Oystercard

  CARD_LIMIT = 90
  MIN_LIMIT = 1
  MIN_FARE = 1

  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "card limit exceeded #{CARD_LIMIT}" if max_limit(amount)
    @balance += amount
  end



  def tap_in
    fail "insufficient funds" if min_limit
    @in_use = true

  end

  def tap_out
    @in_use = false
    deduct(MIN_FARE)
  end

  def in_transit?
    @in_use
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
