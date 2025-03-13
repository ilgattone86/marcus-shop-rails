class CreateStocks < ActiveRecord::Migration[8.0]
  def change
    create_table :stocks do |t|
      t.references :part_option, foreign_key: true, null: false, comment: 'The part option that the stock belongs to'
      t.integer :number_of_units, null: false, default: 0, comment: 'The number of units in stock'

      t.timestamps
    end
  end
end
