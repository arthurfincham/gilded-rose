require "./lib/item"
require "./lib/aged_brie"
require "./lib/conjured_item"
require "./lib/legendary_item"
require "./lib/standard_item"
require "./lib/backstage_pass"

class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case
      when item.name.include?("Sulfuras")
        LegendaryItem.new(item).update
      when item.name.include?("Aged Brie")
        AgedBrie.new(item).update
      when item.name.include?("Backstage passes")
        BackstagePass.new(item).update
      when item.name.include?("Conjured")
        ConjuredItem.new(item).update
      else
        StandardItem.new(item).update
      end
    end
  end
end
