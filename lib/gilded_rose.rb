require './lib/item'

class GildedRose

  attr_accessor :items

  def initialize
    @items = []
  end

  def update_days(item)
    item.sell_in -= 1
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality > 0 && item.sell_in >= 0
    item.quality -= 1 if item.quality == 1 && item.sell_in < 0
    item.quality -= 2 if item.quality > 1 && item.sell_in < 0
  end

  def pass_quality(item)
    case
    when item.sell_in <= 0
      item.quality = 0
    when item.sell_in <= 5
      3.times { increase_quality(item) }
    when item.sell_in <= 10
      2.times { increase_quality(item) }
    else
      increase_quality(item)
    end
  end

  def update_item(item)
    case
    when item.name.include?("Sulfuras")
      item
    when item.name.include?("Aged Brie")
      update_days(item)
      increase_quality(item)
    when item.name.include?("Backstage passes")
      update_days(item)
      pass_quality(item)
    else
      update_days(item)
      decrease_quality(item)
    end
  end

  def update_quality
    @items.each do |item|
      update_item(item)
    end
  end
end
