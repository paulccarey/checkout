# frozen_string_literal: true

module Checkout
  # Represents a basket that contains promotions, products and discounts
  class Basket < Dry::Struct
    transform_keys(&:to_sym)

    attribute :promotions, Types::Array.of(Types.Instance(Checkout::Promotions::PromotionBase))
  end
end
