require 'aged_brie'
require 'mock_item'

describe AgedBrie do
  context 'sell_in is not negative' do
    subject { described_class.new(MockItem.new('Aged Brie', 10, 48)) }
    it 'increases the quality of the item' do
      expect { subject.update }.to change { subject.item.quality }.by(1)
    end

    it 'does not increase quality past 50' do
      subject.update
      subject.update
      expect { subject.update }.to change { subject.item.quality }.by(0)
    end
  end

  context 'sell_in is negative' do
    subject { described_class.new(MockItem.new('Aged Brie', -2, 28)) }
    it 'increases the quality of the item by 2' do
      expect { subject.update }.to change { subject.item.quality }.by(2)
    end
  end
end
