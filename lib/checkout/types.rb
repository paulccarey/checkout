require 'dry-types'
require 'monetize'

module Checkout
  module Types
    include Dry.Types();

    Money = Types.Constructor(Money) { |value|  Monetize.parse(value,:gbp, assume_from_symbol: true ) }
    Proc = Types.Instance(Proc)
    ProductCode = Types::String.constrained(format: /^\d{3}$/)
  end
end
