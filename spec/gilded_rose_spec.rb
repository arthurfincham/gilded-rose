require 'gilded_rose'
require 'mock_item'

describe GildedRose do
  let(:legendary_item) { double :legendary_item }
  let(:aged_brie) { double :aged_brie }
  let(:backstage_pass) { double :backstage_pass }
  let(:conjured_item) { double :conjured_item }
  let(:standard_item) { double :standard_item }

  describe '.update_quality for legendary items' do
    mock_item = MockItem.new('Sulfuras', 10, 10)
    subject { described_class.new([mock_item]) }
    it 'legendary_item' do
      expect(LegendaryItem).to receive(:new).with(mock_item).and_return(legendary_item)
      expect(legendary_item).to receive(:update)
      subject.update_quality
    end
  end

  describe '.update_quality for aged brie' do
    mock_item = MockItem.new('Aged Brie', 10, 10)
    subject { described_class.new([mock_item]) }
    it 'aged_brie' do
      expect(AgedBrie).to receive(:new).with(mock_item).and_return(aged_brie)
      expect(aged_brie).to receive(:update)
      subject.update_quality
    end
  end

  describe '.update_quality for backstage passes' do
    mock_item = MockItem.new('Backstage passes', 10, 10)
    subject { described_class.new([mock_item]) }
    it 'backstage_pass' do
      expect(BackstagePass).to receive(:new).with(mock_item).and_return(backstage_pass)
      expect(backstage_pass).to receive(:update)
      subject.update_quality
    end
  end

  describe '.update_quality for legendary items' do
    mock_item = MockItem.new('Sulfuras', 10, 10)
    subject { described_class.new([mock_item]) }
    it 'legendary_item' do
      expect(LegendaryItem).to receive(:new).with(mock_item).and_return(legendary_item)
      expect(legendary_item).to receive(:update)
      subject.update_quality
    end
  end

  describe '.update_quality for conjured items' do
    mock_item = MockItem.new('Conjured', 10, 10)
    subject { described_class.new([mock_item]) }
    it 'conjured_item' do
      expect(ConjuredItem).to receive(:new).with(mock_item).and_return(conjured_item)
      expect(conjured_item).to receive(:update)
      subject.update_quality
    end
  end

  describe '.update_quality for standard items' do
    mock_item = MockItem.new('Standard', 10, 10)
    subject { described_class.new([mock_item]) }
    it 'standard_item' do
      expect(StandardItem).to receive(:new).with(mock_item).and_return(standard_item)
      expect(standard_item).to receive(:update)
      subject.update_quality
    end
  end

  describe 'The Gold Standard' do
    it 'writes the same output as the Gold Standard' do
      `ruby spec/texttest_fixtures.rb 20 > test.txt`
      expected = 'spec/gold_standard.txt'
      actual = 'test.txt'

      expect(IO.read(actual)).to eq IO.read(expected)
      `rm test.txt`
    end
  end
end
