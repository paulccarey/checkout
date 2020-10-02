# frozen_string_literal: true

require 'spec_helper'

module Checkout
  RSpec.describe Product do
    subject { described_class }

    it 'accepts hash keys as strings or symbols' do
      expect { described_class.new('code': '001', 'name': 'Lavender heart', 'price': '£9.25') }.to_not raise_error
      expect { described_class.new(code: '001', name: 'Lavender heart', price: '£9.25') }.to_not raise_error
    end

    it { is_expected.to have_attribute(:code, Checkout::Types::ProductCode) }
    it { is_expected.to have_attribute(:name, Checkout::Types::Strict::String) }
    it { is_expected.to have_attribute(:price, Checkout::Types::Money) }
  end
end
