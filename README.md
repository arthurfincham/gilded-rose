## Gilded Rose Kata

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

### Round 1

To complete this kata, I began by TDDing the various methods that I would need for the GildedRose class.

The requirements state that for most items, the _sell_in_ would decrease - a `.update_days` method followed.

Similarly, some items increase in _quality_ while others decrease; methods for `.increase_quality` and `.decrease_quality` came along too.

For special items such as Aged Brie and Backstage Passes, a distinct method was required. These methods make use of methods which were previously implemented.

Then, when iterating through the items held by the GildedRose, a switch statement would determine which methods are required based on the name of the item.

Importantly, I made a gold standard file with the output from the original code. This meant that I could make changes to the codebase while knowing that I had something _gold_ to compare it to.

My first iteration of the exercise resulted in the following class (along with an untouched Item class).

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
This seemed like too much work for the GildedRose though.

### Round 2

Next, I planned to create a sub-class for each type of item; one for Standard, another for Aged Brie, etc.

The benefit of this is that when adding further types of item, they can be integrated easily with their own class. 

To move in that direction, I created a method for each of these classes within Gilded Rose, which I would then turn into their own classes.

```ruby
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
```
### Final Round

First came the StandardItem class which acts as a parent to the other _special_ classes; the latter of which inherit `.initialise` and `.quality_cap` from StandardItem.

The `.update` method for each of these classes is the same as the methods listed above.

The benefit of this approach is that if further special items are added to the inventory, they can be easily integrated in two steps:

1. Creating their own class which inherits from StandardClass

2. Adding the class to the `.item_class` switch statement.

For example a *FineWine* which has no sell_in and increases in quality.

```ruby
# ./lib/gilded_rose.rb
...
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
    when name.include?('Wine')
      FineWine
    else
      StandardItem
    end
  end
...
```

```ruby
# ./lib/fine_wine.rb
class FineWine < StandardItem
  def update
    item.quality += 1
  end
end
```

This, I believe, would slot in easily.

### References

[Source Code](https://github.com/emilybache/GildedRose-Refactoring-Kata) translated by Emily Bache.