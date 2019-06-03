require 'oystercard'

describe Oystercard do
  it 'knows Oystercard class exists' do
    expect(described_class).to eq(Oystercard)
  end

  describe 'Initialization' do
    it 'has a balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end
end
