describe 'deleting a line item from cart', :type => :feature, :js => true do
  context 'successful delete' do 
    before do 
      visit "/"
      first('.button_to').click_on("Add to Cart")
      @cart = Cart.find(page.get_rack_session_key('cart_id'))
      visit "/carts/#{@cart.id}"
      click_button("Remove").first
    end

    it 'deletes a line_item asychronously' do 
      expect(@cart.line_items).to be_empty
    end

    context 'changing total' do 
      before do 
        @total = page.find(:css, '#total').text
      end

      it 'changes the cart total asychronously on the page' do 
        expect(@total).to eq('$0')
      end

      it 'change should be reflected in the backend' do 
        expect(@total.gsub('$', '').to_i).to eq(@cart.total / 100)
      end

      it 'stripe iframe knows about the new total' do 
        expect(page.find(: xpath, 'string(//*[@id="stripe-button"]/form/script/@data-amount)').text).to eq(@cart.total)
      end
    end
  end
end