# frozen_string_literal: true

require 'money'
require 'dry-struct'
require 'checkout/version'
require 'checkout/types'
require 'checkout/promotions/promotion_base'
require 'checkout/promotions/threshold_discount_promotion'
require 'checkout/promotions/product_discount_promotion'
require 'checkout/product'
require 'checkout/line_item'
require 'checkout/basket'

# Checkout is an implementation of the checkout code challenge
module Checkout
  class Error < StandardError; end

  Money.default_currency = Money::Currency.new('GBP')

  def self.new(promotions)
    Basket.new(promotions: promotions)
  end
end
