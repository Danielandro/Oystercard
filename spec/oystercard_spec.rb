require 'oystercard'

describe Oystercard do
  describe 'Initialization' do
    it 'has a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    
    it 'increases balance by 10' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it "prevents balance exceeding £#{Oystercard::BALANCE_LIMIT}" do
      expect { subject.top_up(100) }.to raise_error("Balance cannot be over £#{Oystercard::BALANCE_LIMIT}")
    end
  end

  describe '#deduct' do
    it 'reduces balance by 10' do
      expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
    end
  end

end
