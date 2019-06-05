class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :entry_station

  def initialize
    @balance = 0    
    @entry_station 
  end

  def top_up(amount)
    raise "Balance cannot be over £#{BALANCE_LIMIT}" if limit_exceeded?(amount)

    @balance += amount
  end  

  def in_journey?     
    !!@entry_station
  end

  def touch_in(entry_station)
    raise "Not enough funds" if not_enough_funds?
    
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  attr_reader :in_journey

  def deduct(amount)
    @balance -= amount
  end

  def limit_exceeded?(amount)
    balance + amount > BALANCE_LIMIT
  end

  def not_enough_funds?
    balance < MINIMUM_FARE
  end
end
