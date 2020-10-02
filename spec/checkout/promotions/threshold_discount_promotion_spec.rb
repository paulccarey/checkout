# frozen_string_literal: true

require 'spec_helper'

module Checkout
  module Promotions
    RSpec.describe ThresholdDiscountPromotion do
      subject { described_class }

      it { is_expected.to have_attribute(:discount_threshold, Checkout::Types::Money) }
      it { is_expected.to have_attribute(:discounting_proc, Checkout::Types::Proc) }
      it { is_expected.to have_attribute(:description, Checkout::Types::String) }
    end
  end
end
