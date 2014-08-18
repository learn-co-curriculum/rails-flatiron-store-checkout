class CartsController < ApplicationController
  before_filter :set_cart, only: [:show, :checkout]

  def show
  end

  private
  def set_cart
    @cart = Cart.find(params[:id])
  end
end
