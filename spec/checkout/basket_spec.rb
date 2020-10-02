# frozen_string_literal: true

require 'spec_helper'

module Checkout
  RSpec.describe Basket do
    subject { described_class }

    it {
      is_expected.to have_attribute(
        :promotions,
        Types::Array.of(Types.Instance(Checkout::Promotions::PromotionBase)).default([])
      )
    }
    it { is_expected.to have_attribute(:items, Types::Array.of(Types.Instance(Checkout::Product)).default([])) }

    describe '#scan' do
      let(:basket) { Checkout::Basket.new }

      it 'adds the product to the basket items' do
        product = Checkout::Product.new('code': '001', 'name': 'Lavender heart', 'price': '£9.25')
        basket.scan(product)
        expect(basket.items).to include(product)
      end

      it 'raises an error if the item is not a Product' do
        expect { basket.scan(:product) }.to raise_error(
          Checkout::Basket::ItemNotProductError,
          "Only items of type #{Checkout::Product.name} can be scanned"
        )
      end
    end
  end
end
