require 'oystercard'

describe Oystercard do
  describe 'Initialization' do
    it 'has a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'increases balance by 10' do                
      expect(subject.top_up(10)).to eq(10)
    end
  end

end
