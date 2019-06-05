require 'oystercard'

describe Oystercard do
  before(:each) do
    @amount = 10
  end

  

  describe 'Initialization' do
    it 'has a balance of 0' do
      expect(subject.balance).to eq(0)
    end
    it { is_expected.not_to be_in_journey }
  end

  describe '#top_up' do
    it 'increases balance by 10' do
      expect { subject.top_up(@amount) }.to change { subject.balance }.by(@amount)
    end

    it "prevents balance exceeding £#{Oystercard::BALANCE_LIMIT}" do
      message = "Balance cannot be over £#{Oystercard::BALANCE_LIMIT}"
      expect { subject.top_up(100) }.to raise_error(message)
    end
  end

  describe 'on journey' do      

    let(:station) { double 'station' }
    before(:each) do
      @amount = 10
    end

    describe '#touch_in' do
      it 'is in journey after touching in' do  
        subject.top_up(@amount)      
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it "raises an error if I have less than £#{Oystercard::MINIMUM_FARE}" do
        message = "Not enough funds"
        expect { subject.touch_in(station) }.to raise_error(message)
      end

     it 'remembers station on touch in' do
        subject.top_up(@amount)      
        subject.touch_in(station)
        expect(subject.entry_station).to eq(station)
      end
    end

    describe '#touch_out' do
      before(:each) do
        subject.top_up(@amount) 
        subject.touch_in(station)
      end

      it 'is not in journey after touching out' do  
        subject.touch_out(station)
        expect(subject).not_to be_in_journey
      end

      it 'deducts correct amount' do    
        expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end
    end

    it 'saves station when touching out' do
      subject.top_up(@amount) 
      subject.touch_in(station)
      subject.touch_out(station)

      expect(subject.exit_station).to eq(station)
    end

    it 'populates current journey with entry and exit stations' do
      subject.top_up(@amount) 
      subject.touch_in(station)
      subject.touch_out(station)
      p subject.current_journey
      expect(subject.current_journey).to eq([station, station])      
    end
    
    it { is_expected.to respond_to(:save_journey) }

    it 'saves current journey in journey history' do
      subject.top_up(@amount) 
      subject.touch_in(station)
      subject.touch_out(station)      

      expect(subject.journey_history).to eq({ journey_1: [station, station] })
    end


  
  end

  

end
