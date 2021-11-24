require 'standard_item'
require 'mock_item'

describe StandardItem do
  context 'sell_in is not negative' do
    subject { described_class.new(MockItem.new('Standard', 10, 10)) }
    it 'reduces quality by 1' do
      expect { subject.update }.to change { subject.item.quality }.by(-1)
    end

    it 'reduces sell_in by 1' do
      expect { subject.update }.to change { subject.item.sell_in }.by(-1)
    end
  end

  context 'sell_in is negative' do
    subject { described_class.new(MockItem.new('Standard', -1, 2)) }
    it 'reduces quality by 2' do
      expect { subject.update }.to change { subject.item.quality }.by(-2)
    end

    it 'does not reduce quality below 0' do
      subject.update
      subject.update
      expect(subject.item.quality).to eq 0
    end
  end
end
