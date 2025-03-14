class RemoveStockTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :stocks
  end
end
