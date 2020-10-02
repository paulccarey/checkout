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

module Checkout
  class Error < StandardError; end

  def self.new(promotions)
    Basket.new(promotions: promotions)
  end
end
