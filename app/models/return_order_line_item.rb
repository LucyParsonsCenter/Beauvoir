class ReturnOrderLineItem < ActiveRecord::Base
  belongs_to :return_order
  belongs_to :copy

  def do_return
    copy.do_return()
  end
end
