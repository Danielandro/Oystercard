class Oystercard
  BALANCE_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Balance cannot be over £#{BALANCE_LIMIT}" if limit_exceeded?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    in_journey
  end

  def touch_in
    @in_journey = true
  end

  private

  attr_reader :in_journey

  def limit_exceeded?(amount)
    balance + amount > BALANCE_LIMIT
  end

end
