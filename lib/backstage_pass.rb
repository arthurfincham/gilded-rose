require './lib/standard_item'

class BackstagePass < StandardItem
  def update
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
end
