# frozen_string_literal: true

require 'dry/struct/with_setters'

module Checkout
  # Represents a product that can be added to a basket
  class LineItem < Dry::Struct
    include Dry::Struct::Setters

    transform_keys(&:to_sym)

    attribute :code, Checkout::Types::ProductCode.optional
    attribute :description, Checkout::Types::String
    attribute :unit_price, Checkout::Types::Money
    attribute :quantity, Checkout::Types::Integer
  end
end
