describe 'placing order spec', :type => :feature do
  context 'a stripe payment', :js => true do
    before do 
      visit "/"
      first('.button_to').click_on("Add to Cart")
      @cart = Cart.find(page.get_rack_session_key('cart_id'))
      visit "/"
      page.all(:css, '.button_to').last.click_on("Add to Cart")
    end

    it 'loads the stripe modal' do
      visit "/carts/#{@cart.id}"
      click_button "Pay with Card"
      Capybara.within_frame 'stripe_checkout_app' do
        page.execute_script '$("#card_number").val("4242424242424242")'
        page.execute_script '$("#cc-exp").val("01/20")'
        fill_in 'cc-csc', :with => '217'
        click_button 'Pay'
      end
    end
  end
end