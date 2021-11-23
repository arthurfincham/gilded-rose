require "backstage_pass"
require "mock_item"

describe BackstagePass do
  context "more than 10 days remain" do
    subject { described_class.new(MockItem.new("Backstage passes", 12, 20)) }
    it "increases quality by 1" do
      expect { subject.update }.to change { subject.item.quality }.by (1)
    end
  end

  context "10 - 6 days remain" do
    subject { described_class.new(MockItem.new("Backstage passes", 10, 20)) }
    it "increases quality by 2" do
      expect { subject.update }.to change { subject.item.quality }.by (2)
    end
  end

  context "5 - 0 days remain" do
    subject { described_class.new(MockItem.new("Backstage passes", 5, 20)) }
    it "increases quality by 3" do
      expect { subject.update }.to change { subject.item.quality }.by (3)
    end
  end

  context "after the event" do
    subject { described_class.new(MockItem.new("Backstage passes", -1, 20)) }
    it "loses all quality" do
      expect { subject.update }.to change { subject.item.quality }.by (-20)
    end
  end
end
