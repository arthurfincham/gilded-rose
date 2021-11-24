class StandardItem
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update
    item.quality -= 2 if item.sell_in <= 0
    item.quality -= 1 if item.sell_in.positive?
    item.sell_in -= 1 
    quality_cap(item)
  end

  private

  def quality_cap(item)
    item.quality = 0 if item.quality.negative?
    item.quality = 50 if item.quality > 50
  end
end
