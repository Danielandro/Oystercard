require_relative 'journey'

class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  attr_reader :balance    
  attr_reader :journey_history
  attr_reader :current_journey

  def initialize(journey = Journey.new)
    @balance = 0   
    @journey = journey
    @current_journey = []   
    @journey_history = {}
    @journey_number = 1
  end

  def top_up(amount)
    raise "Balance cannot be over £#{BALANCE_LIMIT}" if limit_exceeded?(amount)
    @balance += amount
  end  

  def in_journey?     
    !current_journey.empty?
  end

  def touch_in(entry_station)
    raise "Not enough funds" if not_enough_funds?  
    save_journey(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)   
    save_journey(exit_station)
  end  

  def save_journey(exit_station)  
    @current_journey << exit_station

    if @current_journey.length == 2
      key = "journey_#{@journey_number}".to_sym   
      @journey_history[key] = @current_journey
   
      @current_journey = []
      @journey_number += 1
    end
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
