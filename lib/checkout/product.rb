require 'dry-struct'

module Checkout
  class Product < Dry::Struct
    transform_keys(&:to_sym)
    
    attribute :code, Types::String.constrained(format: /^\d{3}$/)
    attribute :name, Types::String
    attribute :price, Types::Money
  end
end
