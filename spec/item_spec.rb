require 'item'

describe Item do
  subject { described_class.new('Cake', 5, 10) }
  it 'has a name' do
    expect(subject.name).to eq 'Cake'
  end

  it 'has a sell_in' do
    expect(subject.sell_in).to eq 5
  end

  it 'has a quality' do
    expect(subject.quality).to eq 10
  end

  it 'prints to a string' do
    expect(subject.to_s).to eq 'Cake, 5, 10'
  end
end
