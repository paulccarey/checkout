# frozen_string_literal: true

module Checkout
  module Promotions
    # Base class used for other concrete promotions to inherit from
    class PromotionBase < Dry::Struct
      attribute :description, Checkout::Types::String
    end
  end
end
