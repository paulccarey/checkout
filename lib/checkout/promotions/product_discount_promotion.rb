# frozen_string_literal: true

module Checkout
  module Promotions
    # Applies a discount for a particular product if the purchase quantity is over the threshold required
    class ProductDiscountPromotion < PromotionBase
      attribute :product_code, Checkout::Types::ProductCode
      attribute :discounted_price, Checkout::Types::Money
      attribute :quantity_threshold, Checkout::Types::Integer
    end
  end
end
