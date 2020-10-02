require 'spec_helper'

module Checkout
  RSpec.describe Basket do
    subject { described_class }
    
    it { is_expected.to have_attribute(:promotions, Types::Array.of(Types.Instance(Checkout::Promotions::PromotionBase))) }
  end
end
