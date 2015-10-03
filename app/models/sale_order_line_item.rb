class SaleOrderLineItem < ActiveRecord::Base
  belongs_to :sale_order,:touch => true
  belongs_to :copy

  monetize :sale_price_in_cents,:as=>:sale_price

  def sell
    copy.sell(sale_price)
  end
end
