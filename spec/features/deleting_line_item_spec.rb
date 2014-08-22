describe 'deleting a line item from cart', :type => :feature, :js => true do
  context 'successful delete' do 
    before do 
      visit "/"
      first('.button_to').click_on("Add to Cart")
      @cart = Cart.find(page.get_rack_session_key('cart_id'))
      visit "/carts/#{@cart.id}"
      click_button("Remove").first
    end

    it 'deletes a line_item asynchronically' do 
      expect(page).to_not have_content(@cart.line_items.first.item.title)
    end

    context 'changing total' do 
      it 'changes the cart total asynchronically' do 
        @total = page.find_css('#total').value
        expect(@total).to eq('$0.00')
      end

      it 'change should be reflected in the backend' do 
        expect(@total).to eq(@cart.total)
      end
    end
  end
end