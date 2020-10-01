require 'spec_helper'
require 'rspec/dry/struct'

module Checkout
  RSpec.describe Product do

    subject { described_class }

    it { is_expected.to have_attribute(:code, Types::Strict::String) }
    it { is_expected.to have_attribute(:name, Types::Strict::String) }
    it { is_expected.to have_attribute(:price, Types::Money) }
  end
end
