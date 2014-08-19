RSpec.describe StripePayment, :type => :model do
  before { StripeMock.start }
  after { StripeMock.stop }

  context 'successful order processes payment' do
  end

  context 'failure to process payment' do 
    xit 'raises an exception for Stripe failure' do 
      StripeMock.prepare_card_error(:card_declined)

      expect { Stripe::Charge.create }.to raise_error {|e|
      expect(e).to be_a Stripe::CardError
      expect(e.http_status).to eq(402)
      expect(e.code).to eq('card_declined')
      } 
    end
  end
end
