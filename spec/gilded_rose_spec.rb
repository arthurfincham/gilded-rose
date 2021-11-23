require "gilded_rose"
require "mock_item"

describe GildedRose do
    it "holds against the gold_standard" do
      `ruby spec/texttest_fixtures.rb 20 > test.txt`
      expected = "spec/gold_standard.txt"
      actual = "test.txt"

      expect(IO.read(actual)).to eq IO.read(expected)
      `rm test.txt`
    end

end
