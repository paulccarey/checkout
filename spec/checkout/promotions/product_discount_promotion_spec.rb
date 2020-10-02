# frozen_string_literal: true

require 'spec_helper'

module Checkout
  module Promotions
    # rubocop:disable Metrics/BlockLength
    RSpec.describe ProductDiscountPromotion do
      subject { described_class }

      it { is_expected.to have_attribute(:product_code, Checkout::Types::ProductCode) }
      it { is_expected.to have_attribute(:discounted_price, Checkout::Types::Money) }
      it { is_expected.to have_attribute(:quantity_threshold, Checkout::Types::Strict::Integer) }
      it { is_expected.to have_attribute(:description, Checkout::Types::String.optional.default(nil)) }

      describe '#calculate_discount' do
        let(:line_item1) do
          Checkout::LineItem.new(code: '001', description: 'Lavender heart',
                                 unit_price: Monetize.parse('£9.25'), quantity: 2)
        end
        let(:line_item2) do
          Checkout::LineItem.new(code: '002', description: 'Personalised cufflinks',
                                 unit_price: Monetize.parse('£45.00'), quantity: 1)
        end

        let(:product_discount_promotion) do
          Checkout::Promotions::ProductDiscountPromotion.new(
            product_code: line_item1.code,
            discounted_price: Monetize.parse('£8.50'),
            quantity_threshold: 2,
            description: 'Lavender heart discount'
          )
        end

        it 'returns a line_item containing a discount for a matching product' do
          discount_line_item = product_discount_promotion.calculate_discount([line_item1, line_item2])
          expect(discount_line_item.unit_price).to eq(Monetize.parse('-£0.75'))
          expect(discount_line_item.description).to eq(product_discount_promotion.description)
          expect(discount_line_item.quantity).to eq(line_item1.quantity)
        end
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
