class Inventory < ActiveRecord::Base
  has_many :inventory_copy_confirmations
  has_many :copies, :through => :inventory_copy_confirmations


  def includes_copy?(copy)
    copies.include?(copy)
  end

end
