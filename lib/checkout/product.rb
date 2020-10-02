# frozen_string_literal: true

module Checkout
  # Represents a product that can be added to a basket
  class Product < Dry::Struct
    transform_keys(&:to_sym)

    attribute :code, Checkout::Types::ProductCode
    attribute :name, Checkout::Types::String
    attribute :price, Checkout::Types::Money

    def as_line_item(quantity: 1)
      LineItem.new(code: code, description: name, unit_price: price, quantity: quantity)
    end
  end
end
