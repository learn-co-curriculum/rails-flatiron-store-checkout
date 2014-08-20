RSpec.describe StripePayment, :type => :model do
  before { StripeMock.start }
  after { StripeMock.stop }

  describe '#process' do 
    xit 'raises an exception for a Stripe failure' do 
    end

    xit 'fails if not associated with an order' do 
    end

    context 'successful transaction' do 
      #mock out order
      #mock out stripe payment

      before do 
        stripe_payment.process
      end

      xit 'records the customer information' do 
      end

      xit 'records the charge information' do 
      end
    end
  end

  describe '#save_data' do 
    #mock out order
    #mock out stripe payment

    before do 
      stripe_payment.save_data
    end
    
    xit 'saves the data' do 
    end
  end
end
