require 'rails_helper'

RSpec.describe StripePayment, :type => :model do
  before { StripeMock.start }
  after { StripeMock.stop }

  describe '#process' do 
    it 'creates a new customer' do 
    end

    it 'creates a new charge' do 
    end

    it 'stripe-ifies the price' do 
    end
  end
end
