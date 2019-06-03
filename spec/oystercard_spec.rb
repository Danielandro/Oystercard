require 'oystercard'

describe Oystercard do
  before(:each) do
    @amount = 10
  end

  describe 'Initialization' do
    it 'has a balance of 0' do
      expect(subject.balance).to eq(0)
    end
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

end
