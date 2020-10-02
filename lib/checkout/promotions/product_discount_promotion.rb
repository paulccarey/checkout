# frozen_string_literal: true

module Checkout
  module Promotions
    # Applies a discount for a particular product if the purchase quantity is over the threshold required
    class ProductDiscountPromotion < PromotionBase
      attribute :product_code, Checkout::Types::ProductCode
      attribute :discounted_price, Checkout::Types::Money
      attribute :quantity_threshold, Checkout::Types::Integer

      def calculate_discount(line_items)
        matching_line_item = line_items.find { |li| li.code == product_code }
        return unless matching_line_item.quantity >= quantity_threshold

        discount_per_unit = -(matching_line_item.unit_price - discounted_price)
        LineItem.new(
          code: nil, description: description, unit_price: discount_per_unit, quantity: matching_line_item.quantity
        )
      end

      def application_order
        1
      end
    end
  end
end
