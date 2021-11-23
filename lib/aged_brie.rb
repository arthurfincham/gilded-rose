require './lib/standard_item'
class AgedBrie < StandardItem

  def update
    item.quality += 2 if item.sell_in <= 0
    item.quality += 1 if item.sell_in > 0
    item.sell_in -= 1
    quality_cap(item)
  end

end