describe 'deleting a line item from cart', :type => :feature, :js => true do

  let(:cart) do 
    Cart.first.tap do |cart|
      cart.line_items.create(:item => Item.first)
    end
  end

  context 'successful delete' do 
    before do 
      visit "/carts/#{cart.id}"
      click_button("button[data-id=#{cart.line_items.first.id}]")
    end

    it 'deletes a line_item asynchronically' do 
      expect(page).to_not have_content("cart.line_items.first.id")
    end

    context 'changing total' do 
      it 'changes the cart total asynchronically' do 
        @total = page.find_css('#total').value
        expect(@total).to eq('$0.00')
      end

      it 'change should be reflected on the backend' do 
        expect(@total).to eq(cart.total)
      end
    end
  end
end