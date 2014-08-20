RSpec.describe StripePayment, :type => :model do
  before { StripeMock.start }
  after { StripeMock.stop }

  describe '#process' do 
    xit 'raises an exception for a Stripe failure' do 
    end

    xit 'fails if not associated with an order' do 
    end

    context 'successful transaction' do 
      let(:cart) do 
        Cart.first.tap do |cart|
          cart.line_items.create(:item => Item.first)
        end
      end
      let(:order){Order.new}
      let(:stripe_payment){StripePayment.new}

      before do 
        stripe_payment.process("test@test.com", "token", cart.total)
      end

      it 'belongs to an order' do 
        expect(stripe_payment.order_id).to eq(order.id)
      end

      it 'records the customer information' do 
        expect(stripe_payment.stripe_customer_id).to_not eq(nil)
        expect(stripe_payment.stripe_default_card).to_not eq(nil)
      end

      it 'records the charge information' do 
        expect(stripe_payment.stripe_charge_id).to_not eq(nil)
      end

      it 'saves the data' do 
        expect(stripe_payment).to be_persisted
      end
    end
  end
end
