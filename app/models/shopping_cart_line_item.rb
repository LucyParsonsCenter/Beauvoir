class ShoppingCartLineItem < ActiveRecord::Base
  belongs_to :shopping_cart
  belongs_to :edition
  monetize :cost_in_cents, :as => :cost
end
