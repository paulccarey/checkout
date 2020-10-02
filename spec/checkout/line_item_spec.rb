# frozen_string_literal: true

require 'spec_helper'

module Checkout
  RSpec.describe LineItem do
    subject { described_class }

    it { is_expected.to have_attribute(:code, Checkout::Types::ProductCode.optional) }
    it { is_expected.to have_attribute(:description, Checkout::Types::Strict::String) }
    it { is_expected.to have_attribute(:unit_price, Checkout::Types::Money) }
    it { is_expected.to have_attribute(:quantity, Checkout::Types::Integer) }
  end
end
