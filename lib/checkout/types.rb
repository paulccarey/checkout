# frozen_string_literal: true

require 'dry-types'
require 'monetize'

module Checkout
  # Provides types that can be used as attributes for Dry::Struct classes
  module Types
    include Dry.Types()

    Money = Types.Constructor(Money) { |value| Monetize.parse(value, :gbp, assume_from_symbol: true) }
    Proc = Types.Instance(Proc)
    ProductCode = Types::String.constrained(format: /^\d{3}$/)
  end
end
