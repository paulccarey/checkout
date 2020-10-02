# frozen_string_literal: true

require 'dry-struct'

module Checkout
  # Represents a product that can be added to a basket
  class Product < Dry::Struct
    transform_keys(&:to_sym)

    attribute :code, Checkout::Types::ProductCode
    attribute :name, Checkout::Types::String
    attribute :price, Checkout::Types::Money
  end
end
