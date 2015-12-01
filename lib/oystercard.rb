class Oystercard

  CARD_LIMIT = 90

  attr_reader :balance, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "card limit exceeded #{CARD_LIMIT}" if max_limit(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def tap_in
    @in_use = true

  end

  def tap_out
    @in_use = false
  end

  def in_transit?
    @in_use
  end

private

  def max_limit(amount)
    @balance + amount > CARD_LIMIT
  end

end
