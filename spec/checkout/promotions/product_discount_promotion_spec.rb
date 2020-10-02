# frozen_string_literal: true

require 'spec_helper'

module Checkout
  module Promotions
    RSpec.describe ProductDiscountPromotion do
      subject { described_class }

      it { is_expected.to have_attribute(:product_code, Checkout::Types::ProductCode) }
      it { is_expected.to have_attribute(:discounted_price, Checkout::Types::Money) }
      it { is_expected.to have_attribute(:quantity_threshold, Checkout::Types::Strict::Integer) }
      it { is_expected.to have_attribute(:description, Checkout::Types::String) }
    end
  end
end
