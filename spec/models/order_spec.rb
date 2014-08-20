RSpec.describe Order, :type => :model do
  let(:cart) do 
    Cart.first.tap do |cart|
      cart.line_items.create(:item => Item.first)
    end
  end

  subject{Order.new_from_cart(cart, "stripe@email.com", "stripe_token")}

  describe '.new_from_cart' do
    it 'accepts a cart and stripe payment info' do
      expect(subject.cart).to eq(cart)
      expect(subject.total).to eq(cart.total)
      expect(subject.stripe_token).to eq("stripe_token")
      expect(subject.stripe_email).to eq("stripe@email.com")
    end
  end

  describe '#process_and_save!' do
    context 'with successful payment' do
      before do
        expect(subject).to receive(:process_payment).and_return(true)

        subject.process_and_save!
      end

      it 'changes the order status' do
        expect(subject.status).to eq("submitted")
      end

      it 'changes the inventory status' do
        subject.cart.line_items.each do |li|
          expect(li.item.inventory).to eq(0)
        end
      end

      it 'saves the order object' do
        expect(subject.id).to_not be(nil)
      end
    end

    context 'with an errored payment' do
      before do
        expect(subject).to receive(:process_payment).and_return(false)

        subject.process_and_save!
      end

      it 'keeps the order status as nil' do
        expect(subject.status).to be(nil)
      end

      it 'does not change the inventory' do
        subject.cart.line_items.each do |li|
          expect(li.item.inventory).to eq(1)
        end
      end   

      it 'does not save the order object' do
        expect(subject.id).to be(nil)
      end  
    end
  end

  describe '#process_payment' do
    context 'with a successful stripe payment' do
      let(:payment_processor){stub_model(StripePayment)}
      before do
        expect(payment_processor).to receive(:process).and_return(true)
      end

      it 'returns true' do
        expect(subject.process_payment(payment_processor)).to be(true)
      end

      it 'has one stripe payment associated with it' do 
        subject.process_payment(payment_processor)
        expect(subject.stripe_payment).to eq(payment_processor)
      end
    end
  
    context 'with an error stripe payment' do
      let(:payment_processor){stub_model(StripePayment)}
      before do
        expect(payment_processor).to receive(:process).and_return(false)
        subject.process_payment(payment_processor)
      end

      it 'adds an error on the order payment' do
        expect(subject.errors).to include(:total)
      end

      it 'marks the order as invalid' do
        expect(subject).to_not be_valid
      end
    end
  end
end
