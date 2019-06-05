class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :current_journey
  attr_reader :journey_history

  def initialize
    @balance = 0       
    @current_journey = []
    @journey_history = {}
    @journey_number = 1
  end

  def top_up(amount)
    raise "Balance cannot be over £#{BALANCE_LIMIT}" if limit_exceeded?(amount)

    @balance += amount
  end  

  def in_journey?     
    !@current_journey.empty?
  end

  def touch_in(entry_station)
    raise "Not enough funds" if not_enough_funds?  
    @current_journey << entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = exit_station
    save_journey(exit_station)
  end

  def save_journey(exit_station)  
    @current_journey << exit_station
    key = "journey_#{@journey_number}".to_sym   
    @journey_history[key] = @current_journey
   
    @current_journey = []
    @journey_number += 1
  end

  private

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
