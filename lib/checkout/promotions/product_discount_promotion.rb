module Checkout::Promotions
  class ProductDiscountPromotion < Dry::Struct

    attribute :product_code, Checkout::Types::ProductCode
    attribute :discounted_price, Checkout::Types::Money
    attribute :quantity_threshold, Checkout::Types::Integer
    attribute :description, Checkout::Types::String
  end
end
