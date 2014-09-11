describe 'updating a line item quantity in cart', :type => :feature, :js => true do
  context 'successful update' do 
    before do 
      visit "/"
      first('.button_to').click_on("Add to Cart")
      @cart = Cart.find(page.get_rack_session_key('cart_id'))
      visit "/carts/#{@cart.id}"
    end

    xit 'updates a line_item quantity asychronously' do
      fill_in('exampleInputEmail1', :with => '2')
      expect(@cart.line_items.count).to eq(2)
    end

    context 'changing total' do 
      before do 
        @total = page.find(:css, '.total').text
      end

      xit 'updates line_item total on the page asychronously' do 
      
      end

      xit 'updates the cart total on the page asychronously' do 
      end

      xit 'update is reflected on the backend' do 
      end
    end

  end
end