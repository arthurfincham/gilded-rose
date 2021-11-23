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
end