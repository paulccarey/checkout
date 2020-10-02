# frozen_string_literal: true

require 'spec_helper'

module Checkout
  module Promotions
    # rubocop:disable Metrics/BlockLength
    RSpec.describe ThresholdDiscountPromotion do
      subject { described_class }

      it { is_expected.to have_attribute(:discount_threshold, Checkout::Types::Money) }
      it { is_expected.to have_attribute(:discounting_proc, Checkout::Types::Proc) }
      it { is_expected.to have_attribute(:description, Checkout::Types::String.optional.default(nil)) }

      describe '#calculate_discount' do
        let(:line_item1) do
          Checkout::LineItem.new(code: '001', description: 'Lavender heart',
                                 unit_price: Monetize.parse('£9.25', :gbp), quantity: 2)
        end
        let(:line_item2) do
          Checkout::LineItem.new(code: '002', description: 'Personalised cufflinks',
                                 unit_price: Monetize.parse('£45.00', :gbp), quantity: 1)
        end

        let(:threshold_discount_promotion) do
          fractional = 0.9
          percent_discount_proc = proc { |total| total - (total * fractional) }
          Checkout::Promotions::ThresholdDiscountPromotion.new(
            discount_threshold: Monetize.parse('£60', :gbp, assume_from_symbol: true),
            discounting_proc: percent_discount_proc,
            description: '10% off when you spend over £60'
          )
        end

        it 'returns a line_item containing a discount for 10% off' do
          discount_line_item = threshold_discount_promotion.calculate_discount([line_item1, line_item2])
          expect(discount_line_item.unit_price).to eq(Monetize.parse('-£6.35', :gbp))
          expect(discount_line_item.description).to eq(threshold_discount_promotion.description)
          expect(discount_line_item.quantity).to eq(1)
        end
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
