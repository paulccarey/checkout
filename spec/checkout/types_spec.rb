require 'spec_helper'

module Checkout
  RSpec.describe Types do

    describe 'Money' do

      it 'parses the string and instantiates a Money instance with the correct currency' do
        money_instance = described_class::Money['€100']
        expect(money_instance).to be_instance_of(::Money)
        expect(money_instance.currency.id).to eq(:eur)
      end
    end
  end
end
