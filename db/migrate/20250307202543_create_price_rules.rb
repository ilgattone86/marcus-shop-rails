class CreatePriceRules < ActiveRecord::Migration[8.0]
  def change
    create_table :price_rules do |t|
      t.references :dependent_option, foreign_key: { to_table: :part_options }, null: false, comment: 'The option that has specific price rules'
      t.references :base_option, foreign_key: { to_table: :part_options }, null: false, comment: 'The option that has the base price'

      t.decimal :price_adjustment, precision: 8, scale: 2, null: false, default: 0.0, comment: 'The price adjustment for the pair of options'

      t.timestamps
    end
  end
end
