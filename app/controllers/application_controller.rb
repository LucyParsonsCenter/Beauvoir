class ApplicationController < ActionController::Base
  protect_from_forgery

  protected 
  def current_cart
    begin
      ShoppingCart.find(session[:shopping_cart_id])
    rescue ActiveRecord::RecordNotFound
      new_cart
    end
  end
  
  def new_cart
    shopping_cart = ShoppingCart.create(:shipping_method=>"Pickup",:shipping_subscribe=>true)
    session[:shopping_cart_id] = shopping_cart.id
    shopping_cart
  end
end
