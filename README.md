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

## Potential Improvements

### Add LineItem
Could introduce the concept of a LineItem, these would get created as instances of Product's and could be used to 
store/apply discounts and deal with special cases e.g: a one off damaged item, etc... essentially providing some 
additional flexibility. If the data was persisted this would be required anyway for data integrity in the case of updates 
to Product's.