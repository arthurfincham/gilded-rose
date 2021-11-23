require "gilded_rose"
require "mock_item"

describe GildedRose do
  subject { described_class.new }

  describe ".update_days" do
    it "reduces the days remaining for the item" do
      item = MockItem.new("Cake", 3, 6)
      expect { subject.update_days(item) }.to change { item.sell_in }.by (-1)
    end
  end

  describe ".special_item?" do
    it "returns true for Aged Brie" do
      item = MockItem.new("Aged Brie", 3, 6)
      expect(subject.special_item?(item)).to be true
    end

    it 'returns true for Sulfuras' do
      item = MockItem.new("Sulfuras", 3, 6)
      expect(subject.special_item?(item)).to be true
    end

    it 'returns true for Backstage passes' do
      item = MockItem.new("Backstage passes", 4, 4)
      expect(subject.special_item?(item)).to be true
    end

    it 'returns false for any other item' do
      item = MockItem.new("Chair", 1, 4)
      expect(subject.special_item?(item)).to be false
    end
  end

  describe ".increase_quality" do
    it 'increase the quality of an item' do
      item = MockItem.new("Chair", 1, 4)
      expect{subject.increase_quality(item)}.to change { item.quality }.by (1)
    end

    it 'does not increase quality past 50' do
      item = MockItem.new("Chair", 1, 50)
      expect { subject.increase_quality(item) }.to change { item.quality }.by (0)
    end
  end

  describe ".decrease_quality" do
    it 'reduces the quality of an item' do
      item = MockItem.new("Chair", 1, 5)
      expect{subject.decrease_quality(item)}.to change {item.quality }.by (-1)
    end

    it 'prevents item quality being negative' do
      item = MockItem.new("Chair", 1, 0)
      expect{subject.decrease_quality(item) }.to change { item.quality }.by (0)
    end

    it 'decreases twice as fast if sell_in = 0' do
      item = MockItem.new("Chair", -1, 5)
      expect { subject.decrease_quality(item) }.to change { item.quality }.by (-2)
    end

    it 'negative sell_in does not make quality negative' do
      item = MockItem.new("Chair", -1, 1)
      subject.decrease_quality(item)
      expect(item.quality).to eq 0
    end
  end

  describe '.pass_quality' do
    it 'increase quality by 1 if more than 10 days remain' do
      item = MockItem.new("Backstage passes", 12, 20)
      expect { subject.pass_quality(item) }.to change { item.quality }.by (1)
    end

    it 'increase quality by 2 if 10 days remain' do
      item = MockItem.new("Backstage passes", 10, 20)
      expect { subject.pass_quality(item) }.to change { item.quality }.by (2)
    end

    it 'increase quality by 2 if 7 days remain' do
      item = MockItem.new("Backstage passes", 7, 20)
      expect { subject.pass_quality(item) }.to change { item.quality }.by (2)
    end

    it 'increase quality by 3 if 5 days remain' do
      item = MockItem.new("Backstage passes", 5, 20)
      expect { subject.pass_quality(item) }.to change { item.quality }.by (3)
    end

    it 'increase quality by 3 if 2 days remain' do
      item = MockItem.new("Backstage passes", 2, 20)
      expect { subject.pass_quality(item) }.to change { item.quality }.by (3)
    end

    it 'loses all quality after the event' do
      item = MockItem.new("Backstage passes", 0, 20)
      expect { subject.pass_quality(item) }.to change {item.quality }.by (-20)
    end

  end
end