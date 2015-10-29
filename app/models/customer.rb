class Customer < ActiveRecord::Base
  has_many :purchase_order_line_items #special orders!

  def to_s 
    name_and_id
  end

  def name_and_id
    "#{name} (#{id})"
  end


end
