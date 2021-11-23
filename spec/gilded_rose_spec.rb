require "gilded_rose"
require "mock_item"

describe GildedRose do
  subject { described_class.new(MockItem.new("Standard Item", 3, 6)) }
  describe ".standard_update" do
    it "reduces the days remaining for the item" do
      item = MockItem.new("Standard Item", 3, 6)
      expect { subject.standard_update(item) }.to change { item.sell_in }.by (-1)
    end
  end

  describe ".cheese_update" do
    it "increase the quality of an item" do
      item = MockItem.new("Aged Brie", 1, 4)
      expect { subject.cheese_update(item) }.to change { item.quality }.by (1)
    end

    it "does not increase quality past 50" do
      item = MockItem.new("Aged Brie", 1, 50)
      expect { subject.cheese_update(item) }.to change { item.quality }.by (0)
    end

    it "increase by 2 when sell_in < 0 for Aged Brie" do
      item = MockItem.new("Aged Brie", -5, 12)
      expect { subject.cheese_update(item) }.to change { item.quality }.by (2)
    end
  end

  describe ".standard_update" do
    it "reduces the quality of an item" do
      item = MockItem.new("Standard Item", 1, 5)
      expect { subject.standard_update(item) }.to change { item.quality }.by (-1)
    end

    it "prevents item quality being negative" do
      item = MockItem.new("Standard Item", 1, 0)
      expect { subject.standard_update(item) }.to change { item.quality }.by (0)
    end

    it "decreases twice as fast if sell_in = 0" do
      item = MockItem.new("Standard Item", -1, 5)
      expect { subject.standard_update(item) }.to change { item.quality }.by (-2)
    end

    it "negative sell_in does not make quality negative" do
      item = MockItem.new("Standard Item", -1, 1)
      subject.standard_update(item)
      expect(item.quality).to eq 0
    end
  end

  describe ".pass_update" do
    it "increase quality by 1 if more than 10 days remain" do
      item = MockItem.new("Backstage passes", 12, 20)
      expect { subject.pass_update(item) }.to change { item.quality }.by (1)
    end

    it "increase quality by 2 if 10 days remain" do
      item = MockItem.new("Backstage passes", 10, 20)
      expect { subject.pass_update(item) }.to change { item.quality }.by (2)
    end

    it "increase quality by 2 if 7 days remain" do
      item = MockItem.new("Backstage passes", 7, 20)
      expect { subject.pass_update(item) }.to change { item.quality }.by (2)
    end

    it "increase quality by 3 if 5 days remain" do
      item = MockItem.new("Backstage passes", 5, 20)
      expect { subject.pass_update(item) }.to change { item.quality }.by (3)
    end

    it "increase quality by 3 if 2 days remain" do
      item = MockItem.new("Backstage passes", 2, 20)
      expect { subject.pass_update(item) }.to change { item.quality }.by (3)
    end

    it "loses all quality after the event" do
      item = MockItem.new("Backstage passes", -1, 20)
      expect { subject.pass_update(item) }.to change { item.quality }.by (-20)
    end
  end

  describe ".conjured_update" do
    it "decreases quality by 2" do
      item = MockItem.new("Conjured", 10, 10)
      expect { subject.conjured_update(item) }.to change { item.quality }.by (-2)
    end
  end

  describe ".update_item" do
    context "Sulfuras" do
      it "returns itself" do
        item = MockItem.new("Sulfuras", 10, 10)
        expect(subject.update_item(item)).to eq(item)
      end
    end
    context "Aged Brie calls" do
      it ".cheese_update" do
        item = MockItem.new("Aged Brie", 10, 10)
        expect(subject).to receive(:cheese_update).with(item)
        subject.update_item(item)
      end
    end

    context "Backstage passes calls" do
      it ".pass_update" do
        item = MockItem.new("Backstage passes", 10, 10)
        expect(subject).to receive(:pass_update).with(item)
        subject.update_item(item)
      end
    end
    context "Conjured calls" do
      it ".conjured_update" do
        item = MockItem.new("Conjured", 10, 10)
        expect(subject).to receive(:conjured_update).with(item)
        subject.update_item(item)
      end
    end
    context "Standard Item calls" do
      it ".standard_update" do
        item = MockItem.new("Normal Item", 10, 10)
        expect(subject).to receive(:standard_update).with(item)
        subject.update_item(item)
      end
    end
    it "gold standard == test.txt" do
      `ruby spec/texttest_fixtures.rb 20 > test.txt`
      expected = "spec/gold_standard.txt"
      actual = "test.txt"

      expect(IO.read(actual)).to eq IO.read(expected)
      `rm test.txt`
    end
  end
end
