class AddStateToCopy < ActiveRecord::Migration
  def change
    add_column :copies, :state, :text
  end
end
