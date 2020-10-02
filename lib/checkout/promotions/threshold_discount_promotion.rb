# frozen_string_literal: true

module Checkout
  module Promotions
    # Applies a discount if the total basket value is over the threshold required
    class ThresholdDiscountPromotion < Dry::Struct
      attribute :discount_threshold, Checkout::Types::Money
      attribute :discounting_proc, Checkout::Types::Proc
      attribute :description, Checkout::Types::String
    end
  end
end
