require 'legendary_item'
require 'mock_item'

describe LegendaryItem do
  subject { described_class.new(MockItem.new('Sulfaras', 12, 80)) }
  it 'does not change quality' do
    expect { subject.update }.to change { subject.item.quality }.by(0)
  end

  it 'does not change sell_in' do
    expect { subject.update }.to change { subject.item.sell_in }.by(0)
  end
end
