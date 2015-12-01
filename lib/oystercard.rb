class Oystercard

  CARD_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "card limit exceeded #{CARD_LIMIT}" if @balance + amount > CARD_LIMIT
    @balance += amount

  def deduct(amount)
    @balance -= amount
  end

  end

end
