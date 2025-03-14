class AddStockToPartOption < ActiveRecord::Migration[8.0]
  def change
    add_column :part_options, :stock, :boolean, default: true, null: false
  end
end
