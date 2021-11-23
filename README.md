## Gilded Rose Kata

To complete this kata, I began by TDDing the various methods that I would need for the GildedRose class.

The requirements state that for most items, the sell_in would decrease - a .update_days method followed.

Similarly, some items increase in quality while others decrease; methods for .increase_quality and .decrease_quality came along too.

For special items such as Aged Brie and Backstage Passes, a distinct method was required. These methods make use of methods which were previously implemented.

Then, when iterating through the items held by the GildedRose, a switch statement determines which methods are required based on the name of the item.

## Install
Clone the repository
``` bash
% git clone https://github.com/arthurfincham/gilded-rose
```
Go to the project directory and install dependencies:
```bash
% cd gilded-rose
```
Install dependencies
``` bash
% bundle install
```
Run the test suite!
```bash
% rspec
```

## Process

I refactored it into this GildedRose class:
```ruby
require './lib/item'

class GildedRose

  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_days(item)
    item.sell_in -= 1
  end

  def increase_quality(item)
    item.quality += 2 if item.quality < 50 && item.sell_in < 0
    item.quality += 1 if item.quality < 50 && item.sell_in >= 0
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality > 0 && item.sell_in >= 0
    item.quality -= 1 if item.quality == 1 && item.sell_in < 0
    item.quality -= 2 if item.quality > 1 && item.sell_in < 0
  end

  def conjured_quality(item)
    2.times { decrease_quality(item) }
  end

  def pass_quality(item)
    case
    when item.sell_in < 0
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
    when item.name.include?("Conjured")
      update_days(item)
      conjured_quality(item)
    else 
      update_days(item)
      decrease_quality(item)
    end
  end

  def update_quality()
    @items.each do |item|
      update_item(item)
    end
  end
end
```