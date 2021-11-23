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