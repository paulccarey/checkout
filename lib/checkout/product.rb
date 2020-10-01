require 'dry-struct'

module Checkout
  class Product < Dry::Struct
    attribute :code, Types::String.constrained(format: /^\d{3}$/)
    attribute :name, Types::String
    attribute :price, Types::Money
  end
end
