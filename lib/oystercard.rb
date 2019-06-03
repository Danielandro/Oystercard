class Oystercard
  BALANCE_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Balance cannot be over £#{BALANCE_LIMIT}" if limit_exceeded?(amount)

    @balance += amount
  end

  private

  def limit_exceeded?(amount)
    balance + amount > BALANCE_LIMIT
  end
end
