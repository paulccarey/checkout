# frozen_string_literal: true

module Checkout
  # Represents an instance of a product or discount in the basket
  class LineItem < Dry::Struct
    transform_keys(&:to_sym)

    attribute :code, Checkout::Types::ProductCode.optional
    attribute :description, Checkout::Types::String
    attribute :unit_price, Checkout::Types::Money
    attribute :quantity, Checkout::Types::Integer

    def line_total
      unit_price * quantity
    end

    def quantity=(new_quantity)
      @attributes[:quantity] = new_quantity
    end
  end
end
