require "conjured_item"
require "mock_item"

describe ConjuredItem do
  subject { described_class.new(MockItem.new("Conjured", 10, 10)) }

  it "decreases quality by 2" do
    expect { subject.update }.to change { subject.item.quality }.by (-2)
  end
end
