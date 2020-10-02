# frozen_string_literal: true

require 'spec_helper'

module Checkout
  # rubocop:disable Metrics/BlockLength
  RSpec.describe Basket do
    subject { described_class }

    it {
      is_expected.to have_attribute(
        :promotions,
        Types::Array.of(Types.Instance(Checkout::Promotions::PromotionBase)).default { [] }
      )
    }
    it {
      is_expected.to have_attribute(
        :line_items, Types::Array.of(Types.Instance(Checkout::LineItem)).default { [] }
      )
    }

    describe '#scan' do
      let(:basket) { Checkout::Basket.new(line_items: []) }
      let(:product) { Checkout::Product.new('code': '001', 'name': 'Lavender heart', 'price': '£9.25') }

      context 'product has not been previously scanned' do
        it 'adds creates a new line item using the product details' do
          basket.scan(product)
          line_item = basket.line_items.find { |li| li.code == product.code }
          expect(line_item.code).to eq(product.code)
          expect(line_item.description).to eq(product.name)
          expect(line_item.unit_price).to eq(product.price)
          expect(line_item.quantity).to eq(1)
        end
      end

      context 'product is scanned multiple times' do
        before(:each) do
          basket.scan(product)
        end

        it 'increments the quantity of an existing line item' do
          basket.scan(product)
          line_item = basket.line_items.find { |li| li.code == product.code }
          expect(line_item.code).to eq(product.code)
          expect(line_item.description).to eq(product.name)
          expect(line_item.unit_price).to eq(product.price)
          expect(line_item.quantity).to eq(2)
        end
      end

      it 'raises an error if the item is not a Product' do
        expect { basket.scan(:product) }.to raise_error(
          Checkout::Basket::ItemNotProductError,
          "Only items of type #{Checkout::Product.name} can be scanned"
        )
      end
    end

    describe '#total' do
      let(:line_item1) do
        Checkout::LineItem.new(code: '001', description: 'Lavender heart',
                               unit_price: Monetize.parse('£9.25'), quantity: 2)
      end
      let(:line_item2) do
        Checkout::LineItem.new(code: '002', description: 'Personalised cufflinks',
                               unit_price: Monetize.parse('£45.00'), quantity: 1)
      end

      let(:basket) { Checkout::Basket.new(line_items: [line_item1, line_item2], promotions: promotions) }

      context 'no promotions' do
        let(:promotions) { [] }

        it 'adds together all of the line_items' do
          expect(basket.total).to eq(Monetize.parse('£63.50'))
        end
      end

      context 'with promotions' do
        let(:promotion1) {  Checkout::Promotions::PromotionBase.new }
        let(:promotion2) {  Checkout::Promotions::PromotionBase.new }
        let(:promotion3) {  Checkout::Promotions::PromotionBase.new }
        let(:promotions) { [promotion3, promotion1, promotion2] }

        before(:each) do
          allow(promotion1).to receive(:calculate_discount).and_return(
            LineItem.new(
              code: nil, description: '£5 discount', unit_price: Monetize.parse('-£5.00'), quantity: 1
            )
          )
          allow(promotion1).to receive(:application_order).and_return(1)

          allow(promotion2).to receive(:calculate_discount).and_return(
            LineItem.new(
              code: nil, description: '£2.50 discount', unit_price: Monetize.parse('-£2.50'), quantity: 2
            )
          )
          allow(promotion2).to receive(:application_order).and_return(1)

          allow(promotion3).to receive(:calculate_discount) do |args|
            current_total = args.collect(&:line_total).sum
            if current_total.to_i > 60
              LineItem.new(
                code: nil, description: '£50 discount', unit_price: Monetize.parse('-£50'), quantity: 2
              )

            end
          end
          allow(promotion3).to receive(:application_order).and_return(2)
        end

        it 'applies any applicable discounts in the correct order' do
          expect(basket.total).to eq(Monetize.parse('£53.50'))
        end
      end
    end
  end
  # rubocop:enable Metrics/BlockLength
end
