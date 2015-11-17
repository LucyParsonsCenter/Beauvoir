class DropCustomersTable < ActiveRecord::Migration
  def change
    drop_table :customers
  end
end
