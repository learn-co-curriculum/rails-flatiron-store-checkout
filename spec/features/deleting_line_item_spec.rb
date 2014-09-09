describe 'deleting a line item from cart', :type => :feature, :js => true do
  context 'successful delete' do 
    before do 
      visit "/"
      first('.button_to').click_on("Add to Cart")
      @cart = Cart.find(page.get_rack_session_key('cart_id'))
      visit "/carts/#{@cart.id}"
    end

    it 'deletes a line_item asychronously' do 
      click_button("Remove").first
      expect(@cart.line_items).to be_empty
    end

    context 'changing total' do 
      before do 
        @total = page.find(:css, '#total').text
      end

      it 'changes the cart total asychronously on the page' do 
        click_button("Remove").first
        expect(@total).to eq('$0')
      end

      it 'change should be reflected in the backend' do 
        click_button("Remove").first
        expect(@total.gsub('$', '').to_i).to eq(@cart.total / 100)
      end

      it 'stripe knows about the new total' do
        expect(page.find(:xpath, "//*[@id='stripe-button']/form/script/@data-amount")).to eq(@cart.total.to_s)
      end
    end

    context 'empty shopping cart' do 
      before do
        click_button("Remove").first
      end

      xit 'hides the Pay with Card button when total is 0' do 
      end
    end
  end
end