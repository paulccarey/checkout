# frozen_string_literal: true

module Checkout
  module Promotions
    # Applies a discount for a particular product if the purchase quantity is over the threshold required
    class ProductDiscountPromotion < Dry::Struct
      attribute :product_code, Checkout::Types::ProductCode
      attribute :discounted_price, Checkout::Types::Money
      attribute :quantity_threshold, Checkout::Types::Integer
      attribute :description, Checkout::Types::String
    end
  end
end
