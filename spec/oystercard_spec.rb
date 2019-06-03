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

  describe '#deduct' do
    it 'reduces balance by 10' do
      expect { subject.deduct(@amount) }.to change { subject.balance }.by(-@amount)
    end
  end

  describe 'on journey' do
    describe '#touch_in' do
      it 'is in journey after touching in' do
        subject.top_up(@amount)
        subject.touch_in
        expect(subject).to be_in_journey
      end
      it "raises an error if I have less than £#{Oystercard::MINIMUM_FARE}" do
        message = "Not enough funds"
        expect { subject.touch_in }.to raise_error(message)
      end
    end

    describe '#touch_out' do
      it 'is not in journey after touching out' do
        subject.top_up(@amount)
        subject.touch_in
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      it 'deducts correct amount' do
        subject.top_up(@amount)
        subject.touch_in
        
        expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end
    end
  end

end
