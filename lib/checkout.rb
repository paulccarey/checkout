# frozen_string_literal: true

require 'checkout/version'
require 'money'
require 'checkout/types'
require 'checkout/product'
require 'checkout/promotions/threshold_discount_promotion'
require 'checkout/promotions/product_discount_promotion'

module Checkout
  class Error < StandardError; end
end
