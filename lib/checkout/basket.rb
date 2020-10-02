# frozen_string_literal: true

module Checkout
  # Represents a basket that contains promotions, products and discounts
  class Basket < Dry::Struct
    transform_keys(&:to_sym)

    attribute :promotions, Types::Array.of(Types.Instance(Checkout::Promotions::PromotionBase)).default([])
    attribute :items, Types::Array.of(Types.Instance(Checkout::Product)).default([])

    class ItemNotProductError < StandardError; end

    def scan(product)
      unless product.instance_of?(Checkout::Product)
        raise ItemNotProductError, "Only items of type #{Checkout::Product.name} can be scanned"
      end

      items << product
    end

    def total
      Monetize.parse('£123')
    end
  end
end
