# frozen_string_literal: true

module Checkout
  module Promotions
    # Applies a discount if the total basket value is over the threshold required
    class ThresholdDiscountPromotion < PromotionBase
      attribute :discount_threshold, Checkout::Types::Money
      attribute :discounting_proc, Checkout::Types::Proc
    end
  end
end
