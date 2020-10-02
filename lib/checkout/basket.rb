# frozen_string_literal: true

module Checkout
  # Represents a basket that contains promotions, products and discounts
  class Basket < Dry::Struct
    transform_keys(&:to_sym)

    attribute :promotions, Types::Array.of(Types.Instance(Checkout::Promotions::PromotionBase)).default([])
    attribute :line_items, Types::Array.of(Types.Instance(Checkout::LineItem)).default([])

    class ItemNotProductError < StandardError; end

    def scan(product)
      unless product.instance_of?(Checkout::Product)
        raise ItemNotProductError, "Only items of type #{Checkout::Product.name} can be scanned"
      end

      line_item = line_items.find { |li| li.code == product.code }
      if line_item
        line_item.quantity = line_item.quantity + 1
      else
        line_items << product.as_line_item(quantity: 1)
      end
    end

    def total
      Monetize.parse('£123')
    end
  end
end
