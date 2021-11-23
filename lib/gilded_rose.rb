require './lib/item'

class GildedRose

  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def standard_update(item)
    item.quality -= 2 if item.sell_in <= 0
    item.quality -= 1 if item.sell_in > 0
    item.sell_in -= 1 
    quality_cap(item)
  end

  def pass_update(item)
    case
    when item.sell_in <= 0
      item.quality = 0
    when item.sell_in <= 5
      item.quality += 3
    when item.sell_in <= 10
      item.quality += 2
    else
      item.quality += 1
    end
    item.sell_in -= 1
    quality_cap(item)
  end

  def cheese_update(item)
    item.quality += 2 if item.sell_in <= 0
    item.quality += 1 if item.sell_in > 0
    item.sell_in -= 1
    quality_cap(item)
  end

  def conjured_update(item)
    item.quality -= 2
    item.sell_in -= 1
    quality_cap(item)
  end

  def update_item(item)
    case
    when item.name.include?("Sulfuras")
      item
    when item.name.include?("Aged Brie")
      cheese_update(item)
    when item.name.include?("Backstage passes")
      pass_update(item)
    when item.name.include?("Conjured")
      conjured_update(item)
    else 
      standard_update(item)
    end
  end

  def update_quality()
    @items.each do |item|
      update_item(item)
    end
  end

  private

  def quality_cap(item)
    item.quality = 0 if item.quality < 0
    item.quality = 50 if item.quality > 50
  end
end
