require 'dry-struct'

module Checkout
  class Product < Dry::Struct
    transform_keys(&:to_sym)
    
    attribute :code, Checkout::Types::ProductCode
    attribute :name, Checkout::Types::String
    attribute :price, Checkout::Types::Money
  end
end
