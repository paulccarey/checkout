# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Checkout do
  describe '.new' do

    it 'instantiates a basket with the provided promotions' do
      allow(Checkout::Basket).to receive(:new)
      Checkout.new(:promotions)
      expect(Checkout::Basket).to have_received(:new).with(promotions: :promotions)
    end
  end
end
