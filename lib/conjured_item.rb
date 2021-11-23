require "./lib/standard_item"

class ConjuredItem < StandardItem
  def update
    item.quality -= 2
    item.sell_in -= 1
    quality_cap(item)
  end
end
