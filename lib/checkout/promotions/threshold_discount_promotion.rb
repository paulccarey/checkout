# frozen_string_literal: true

module Checkout
  module Promotions
    # Applies a discount if the total basket value is over the threshold required
    class ThresholdDiscountPromotion < PromotionBase
      attribute :discount_threshold, Checkout::Types::Money
      attribute :discounting_proc, Checkout::Types::Proc

      def calculate_discount(line_items)
        current_total = line_items.collect(&:line_total).sum
        return unless current_total > discount_threshold

        discount = -discounting_proc.call(current_total)
        LineItem.new(
          code: nil, description: description, unit_price: discount, quantity: 1
        )
      end

      def application_order
        2
      end
    end
  end
end
