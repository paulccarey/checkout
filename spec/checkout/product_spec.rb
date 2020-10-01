require 'spec_helper'
require 'rspec/dry/struct'

module Checkout
  RSpec.describe Product do
    subject { described_class }

    it 'accepts hash keys as strings or symbols' do
      expect { described_class.new('code': '001', 'name': 'Lavender heart', 'price': '£9.25') }.to_not raise_error
      expect { described_class.new(code: '001', name: 'Lavender heart', price: '£9.25') }.to_not raise_error
    end

    it { is_expected.to have_attribute(:code, Types::Strict::String.constrained(format: /^\d{3}$/)) }

    it 'only accepts three numeric digits for code' do
      expect { described_class.new(code: '001', name: 'Lavender heart', price: '£9.25') }.to_not raise_error
      expect { described_class.new(code: '0001', name: 'Lavender heart', price: '£9.25') }.to raise_error(Dry::Struct::Error)
      expect { described_class.new(code: 'ABC', name: 'Lavender heart', price: '£9.25') }.to raise_error(Dry::Struct::Error)
    end

    it { is_expected.to have_attribute(:name, Types::Strict::String) }
    it { is_expected.to have_attribute(:price, Types::Money) }
  end
end
