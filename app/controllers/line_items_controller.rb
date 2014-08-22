class LineItemsController < ApplicationController
  before_action :initialize_cart, only: [:create]

  def create
    item = Item.find(params[:item_id])
    @line_item = current_cart.add_item(item.id)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to cart_path(current_cart),
        notice: 'Item added to cart!' }
      else
        redirect_to store_path
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    response_hash = {}
    response_hash[:total] = current_cart.total
    response_hash[:stripe_api] = Rails.configuration.stripe[:publishable_key]
    
    respond_to do |format|
      format.json do
        render json: response_hash
      end
    end
  end
end
