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

    describe 'Proc' do

      it 'rejects anything that is not a Proc' do
        expect { described_class::Proc['not a proc'] }.to raise_error(Dry::Types::ConstraintError)
        expect { described_class::Proc[Proc.new { puts 'hello from proc' }] }.to_not raise_error
      end
    end
  end
end
