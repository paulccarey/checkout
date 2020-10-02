module Checkout::Promotions
  class ThresholdDiscountPromotion < Dry::Struct

    attribute :discount_threshold, Checkout::Types::Money
    attribute :discounting_proc, Checkout::Types::Proc
    attribute :description, Checkout::Types::String
  end
end
