# frozen_string_literal: true

require 'spec_helper'

module Checkout
  # rubocop:disable Metrics/BlockLength
  RSpec.describe Basket do
    subject { described_class }

    it {
      is_expected.to have_attribute(
        :promotions,
        Types::Array.of(Types.Instance(Checkout::Promotions::PromotionBase)).default([])
      )
    }
    it { is_expected.to have_attribute(:line_items, Types::Array.of(Types.Instance(Checkout::LineItem)).default([])) }

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
    end
  end
  # rubocop:enable Metrics/BlockLength
end
