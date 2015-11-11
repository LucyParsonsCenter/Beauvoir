class ChangeEdition < ActiveRecord::Migration
  def change
    change_column :editions, :list_price_cents, :integer, default: 0
    change_column :editions, :in_print, :boolean, default: true
    change_column :editions, :format, :text, default: "Paperback"
  end
end
