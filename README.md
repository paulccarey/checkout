# Checkout

Welcome to checkout.

The code here is for the submission of the checkout code challenge as described within [checkout_challenge.md](checkout_challenge.md).

## Installation and Usage

Checkout the code locally using git.

    $ git clone git@github.com:paulccarey/checkout.git
    
Ensure the correct version of ruby using your version manager, for RVM this is     

    $ rvm use
    
Bundle install the gems

    $ bundle install

Primarly the code can be exercised via the test suite by running rspec

    $ bin/rspec spec
    
This includes acceptance tests and unit tests.

## Thoughts and Considerations
- Interface to checkout could be interpreted in different ways `Checkout.new(promotional_rules)`, is promotional_rules 
just the promos or should this also have included products? 
- Promotions need to be applied in a specific order to prevent them being miss-applied, e.g if we discount specific 
products then the basket value may fall below the threshold required to apply a basket total discount.
- LineItems model allows for "template" of Products and for actual "instances" of purchases to be created, this allows 
for more flexibility, e.g: discretionary discounting if an item is damaged, etc or if the base product price changes 
then existing Basket#line_items are not affected. LineItems can also be used to apply discounts with negative pricing.
This makes calculating totals simple as simply need to add up the sum of LineItems

## Potential Improvements

### Promotion Input as a DSL/Configuration
Currently promotions are setup by passing instances of objects into the checkout (or the basket).
It would be ideal if these where configurable with a human readable DSL or configuration.

### Item scanning and product "database"
Currently Basket#scan requires an item object. An improvement may be to allow a a product code as input e.g "001". 
This would require a lookup to a list of products to find its price, etc.

