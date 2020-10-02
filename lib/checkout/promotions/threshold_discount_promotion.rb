# frozen_string_literal: true

module Checkout
  module Promotions
    # Applies a discount if the total basket value is over the threshold required
    class ThresholdDiscountPromotion < PromotionBase
      attribute :discount_threshold, Checkout::Types::Money
      attribute :discounting_proc, Checkout::Types::Proc

      def application_order
        2
      end
    end
  end
end
