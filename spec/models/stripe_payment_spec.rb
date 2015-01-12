RSpec.describe StripePayment, :type => :model do
  before { StripeMock.start }
  after { StripeMock.stop }

  describe '#process' do 
    let(:cart) do 
        Cart.first.tap do |cart|
          cart.line_items.create(:item => Item.first)
        end
      end
    let(:order){Order.new}
    let(:payment){StripePayment.new}
    let(:card_token){StripeMock.generate_card_token(last4: "9191", exp_year: 1984)}

    context 'failed transaction' do
      it 'raises an exception for a Stripe failure' do 
        StripeMock.prepare_card_error(:card_declined)
        expect { payment.process("test@test.com", card_token, cart.total) }.to raise_error(Stripe::CardError)
      end
    end

    context 'successful transaction' do   
      before do 
        payment.process("test@test.com", card_token, cart.total)
      end

      it 'records the customer information' do 
        expect(payment.stripe_customer_id).to_not eq(nil)
        expect(payment.stripe_default_card).to_not eq(nil)
      end

      it 'records the charge information' do 
        expect(payment.stripe_charge_id).to_not eq(nil)
      end

      it 'saves the data' do 
        expect(payment).to be_persisted
      end
    end
  end
end
