require 'dry-struct'

module Checkout
  class Product < Dry::Struct
    attribute :code, Types::String
    attribute :name, Types::String
    attribute :price, Types::Money
  end
end
