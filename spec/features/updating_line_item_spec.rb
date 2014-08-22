describe 'updating a line item quantity in cart', :type => :feature, :js => true do
  context 'successful update' do 
    before do 
      visit "/"
      first('.button_to').click_on("Add to Cart")
      @cart = Cart.find(page.get_rack_session_key('cart_id'))
      visit '/'
      first('.button_to').click_on("Add to Cart")
      visit "/carts/#{@cart.id}"
    end

    xit 'updates a line_item quantity asychronously' do 
      expect(@cart.line_items.count).to eq(2)
    end

    xit 'updates line_item total on the page asychronously' do 
    end

    xit 'updates the cart total on the page asychronously' do 
    end

    xit 'update is reflected on the backend' do 
    end
  end
end