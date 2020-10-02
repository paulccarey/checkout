# frozen_string_literal: true

module Checkout
  # Represents a basket that contains promotions, products and discounts
  class Basket < Dry::Struct
    transform_keys(&:to_sym)

    # rubocop:disable Lint/AmbiguousBlockAssociation
    attribute :promotions, Types::Array.of(Types.Instance(Checkout::Promotions::PromotionBase)).default { [] }
    attribute :line_items, Types::Array.of(Types.Instance(Checkout::LineItem)).default { [] }
    # rubocop:enable Lint/AmbiguousBlockAssociation

    class ItemNotProductError < StandardError; end

    def scan(product)
      unless product.instance_of?(Checkout::Product)
        raise ItemNotProductError, "Only items of type #{Checkout::Product.name} can be scanned"
      end

      line_item = line_items.find { |li| li.code == product.code }
      if line_item
        line_item.quantity = line_item.quantity + 1
      else
        line_items << product.as_line_item(quantity: 1)
      end
    end

    def total
      line_items_with_discounts.collect(&:line_total).sum
    end

    private

    def sorted_promotions
      promotions.sort_by(&:application_order)
    end

    def line_items_with_discounts
      sorted_promotions.each_with_object(line_items.clone) do |promotion, line_items|
        discount_item = promotion.calculate_discount(line_items)
        line_items << discount_item unless discount_item.nil?
      end
    end
  end
end
