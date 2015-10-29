class InventoryCopyConfirmation < ActiveRecord::Base
  belongs_to :inventory
  belongs_to :copy
end
