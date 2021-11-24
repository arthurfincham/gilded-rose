require './lib/item'
require './lib/aged_brie'
require './lib/conjured_item'
require './lib/legendary_item'
require './lib/standard_item'
require './lib/backstage_pass'

class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items.map { |item| item_class(item.name).new(item) }
  end

  def update_quality
    @items.each do |item|
      item.update
    end
  end

  def item_class(name)
    case
    when name.include?('Sulfuras')
      LegendaryItem
    when name.include?('Aged Brie')
      AgedBrie
    when name.include?('Backstage passes')
      BackstagePass
    when name.include?('Conjured')
      ConjuredItem
    else
      StandardItem
    end
  end
end
